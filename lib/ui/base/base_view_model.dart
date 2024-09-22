import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import '../../core/constants/app_config.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_alert_dialog.dart';
import '../../core/resources/_r.dart';
import '../../core/utils/general_data.dart';

abstract class ViewModelBase extends ChangeNotifier {
  ActivityState activityState = ActivityState.isLoaded;

  ErrorProperty errorObserver = ErrorProperty();
  AlertProperty alertObserver = AlertProperty();

  bool isLoadingPagination = false;
  int page = 0;
  final int take = GeneralData.getInstance().takeCount;
  int? totalListCount;
  bool isEndPagination = false;

  bool isDetectError = false;
  Map<String, dynamic> errorFields = {};

  void init();

  List<int>? getPages() {
    if(totalListCount == null) {
      return null;
    }
    if (totalListCount! <= 0) {
      return null;
    }
    final result = <int>[];
    for (var i = 10; i <= totalListCount!; i += 10) {
      result.add(i);
    }
    if (totalListCount! % 10 != 0) {
      result.add(totalListCount!);
    }
    return result;
  }
  
  bool checkErrorByField(String fieldName) => errorFields[fieldName] != null;

  String? getErrorMsg(String fieldName) => errorFields[fieldName];

  void setActivityState(ActivityState state, [String errMsg = '']) {
    activityState = state;
    if (state == ActivityState.isLoading || state == ActivityState.isLoaded) {
      errMsg = '';
    } else {
      errorObserver.message = errMsg;
    }
    notifyListeners();
  }

  bool isLoading() => activityState == ActivityState.isLoading;
  bool isLoaded() => activityState == ActivityState.isLoaded;

  bool isError() => activityState == ActivityState.isError;

  Future<void> handleApiError(dynamic error) async {
    log(error.toString());
    activityState = ActivityState.isError;
    if (error is DioException) {
      errorObserver.message = error.message ?? '';
      if (error.response != null) {
        switch (error.response!.statusCode) {
          case 401:
            logout(true);
          default:
        }
      }
    } else {
      errorObserver.message = R.string.genericError;
    }
    notifyListeners();
  }

  void logout([bool isDirectLogout = false]) {
    errorObserver.activityErrorActionState = isDirectLogout ? ActivityErrorActionState.directLogout : ActivityErrorActionState.logout;
  }
}

class ErrorProperty extends PropertyChangeNotifier<String> {
  String _message = '';
  String get message => _message;

  ActivityErrorActionState _activityErrorActionState = ActivityErrorActionState.none;
  ActivityErrorActionState get activityErrorActionState => _activityErrorActionState;

  set message(String value) {
    _message = value;
    notifyListeners(errorPropertyMessageTag);
  }

  set activityErrorActionState(ActivityErrorActionState value) {
    _activityErrorActionState = value;
    notifyListeners(errorPropertyActivityActionStateTag);
  }
}

class AlertProperty extends PropertyChangeNotifier<String> {
  ModelAlertDialog? _alert;
  ModelAlertDialog get alert => _alert ?? const ModelAlertDialog(description: '', dialogType: DialogTypes.warning);

  set alert(ModelAlertDialog? value) {
    _alert = value;
    notifyListeners(alertPropertyTag);
  }
}
