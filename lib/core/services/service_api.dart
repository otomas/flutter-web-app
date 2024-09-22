import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../core/services/service_firebase.dart';
import '../constants/app_config.dart';
import '../resources/_r.dart';
import '../settings/controller_language.dart';
import '../utils/flavor_config.dart';
import 'api/api_client.dart';

class ServiceApi extends ChangeNotifier {
  ServiceApi(this.accessToken, this.taxNumber, this._firebaseService) {
    createDio();
  }
  late Dio dio;

  late ApiClient _client;

  final ServiceFirebase _firebaseService;

  ApiClient get client => _client;

  final String tagAuthorization = 'Authorization';
  String? accessToken;

  String? taxNumber;

  void createDio() {
    dio = Dio(BaseOptions(headers: accessToken == null ? {} : {tagAuthorization: 'Bearer $accessToken'}, connectTimeout: const Duration(seconds: 120)));

    if (!kIsWeb) {
      dio.httpClientAdapter = (IOHttpClientAdapter()..createHttpClient = () => HttpClient()..badCertificateCallback = ((cert, host, port) => true));
    }

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: onRequest, onResponse: onResponse, onError: onError));
    dio.options.headers.addAll(getHeaderData);
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) => status != null && status < 500;

    createClient();
  }

  void createClient() {
    _client = ApiClient(dio, baseUrl: FlavorConfig.instance.values.baseUrl);
  }

  Map<String, String> get getHeaderData {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      tagAuthorization: 'Bearer $accessToken',
      'X-Tenant': '$taxNumber',
      'Accept-Language': LanguageController.currentLocale.languageCode,
    };
    return headers;
  }

  void reCreateHeaders() {
    dio.options.headers = getHeaderData;
  }

  void setAuthToken(String? accessToken) {
    this.accessToken = accessToken;
    if (accessToken != null) {
      if (dio.options.headers[tagAuthorization] != null) {
        dio.options.headers[tagAuthorization] = 'Bearer $accessToken';
      } else {
        dio.options.headers.addEntries([MapEntry(tagAuthorization, 'Bearer $accessToken')]);
      }
    } else {
      dio.options.headers.removeWhere((key, value) => key == tagAuthorization);
    }
  }

  void setTaxNumber(String? taxNumber) {
    this.taxNumber = taxNumber;
    if (taxNumber == null) {
      dio.options.headers.removeWhere((key, value) => key == 'X-Tenant');
      return;
    }
    if (dio.options.headers['X-Tenant'] == null) {
      dio.options.headers.addEntries([MapEntry('X-Tenant', taxNumber)]);
    } else {
      dio.options.headers['X-Tenant'] = taxNumber;
    }
  }

  Future<void> onError(DioException e, ErrorInterceptorHandler handler) async {
    var msg = R.string.genericError;
    if (e.response?.data != null) {
      if (e.response?.data is Map) {
        msg = e.response?.data?['error']?['description'] ?? R.string.genericError;
      } else {
        msg = R.string.genericError;
      }
    }
    await _firebaseService.recordError(
      parameters: {
        'url': e.requestOptions.uri.toString(),
        'responseCode': e.response?.statusCode,
        'responseMessage': e.response?.statusMessage,
        'requestBody': e.requestOptions.data.toString(),
        'responseBody': e.response?.data.toString(),
        'userSendedMessage': msg,
      },
    );
    e = e.copyWith(message: msg);
    return handler.next(e);
  }

  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (unAuthRequestEndpoints.contains(options.uri.path)) {
      options.headers.removeWhere((key, value) => key == 'X-Tenant');
    } else {
      options.headers = getHeaderData;
    }
    // if (await isOnline()) {
    return handler.next(options);
    // }
    // return handler.reject(DioException(requestOptions: options, message: R.string.networkError));
  }

  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final isSuccess = response.data?['status'] ?? false;
    if (isSuccess) {
      return handler.next(response);
    } else {
      var e = DioException(requestOptions: RequestOptions(), response: response);
      final String errorMessage = response.data?['error']?['description'] ?? R.string.genericError;
      e = e.copyWith(message: errorMessage);

      await _firebaseService.recordError(
        parameters: {
          'url': e.requestOptions.uri.toString(),
          'responseCode': e.response?.statusCode,
          'responseMessage': e.response?.statusMessage,
          'requestBody': e.requestOptions.data.toString(),
          'responseBody': e.response?.data.toString(),
          'userSendedMessage': errorMessage,
        },
      );

      return handler.reject(e);
    }
  }
}
