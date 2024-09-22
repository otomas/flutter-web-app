import 'dart:async';
import 'dart:developer';
import '../../../core/models/request/model_request_register_device.dart';
import '../../../core/services/service_api.dart';
import '../../../core/services/service_device_info.dart';
import '../../../core/services/service_firebase.dart';
import '../../../core/settings/controller_language.dart';
import '../../../core/utils/general_data.dart';
import '../../../core/utils/utilities.dart';
import '../../../ui/base/base_view_model.dart';

class VmSplash extends ViewModelBase {

  VmSplash(this.serviceApi, this.serviceFirebase, this.serviceDeviceInfo) {
    unawaited(init());
  }
  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final ServiceDeviceInfo serviceDeviceInfo;

  @override
  Future<void> init() async {

    final authToken = GeneralData.getInstance().getAuthToken();
    log(authToken.toString(), name: 'AUTH TOKEN');
  }

  Future<void> checkDeviceRegister() async {
    final deviceId = await GeneralData.getInstance().getDeviceId();
    log(deviceId, name: 'DEVICE ID');
    if (GeneralData.getInstance().getIsChangedFCMToken()) {
      if (GeneralData.getInstance().getDeviceIsRegistered()) {
        await _updateDevice(deviceId);
      } else {
        await _registerDevice(deviceId);
      }
    }
  }

  Future<void> _registerDevice(String deviceId) async {
    final body = ModelRequestDeviceRegister(
      id: deviceId,
      fcmToken: GeneralData.getInstance().getFCMToken(),
      ipAddress: await printIps(),
      macAddress: serviceDeviceInfo.macAddress,
      latitude: 0,
      longitude: 0,
      //platform: Platform.isAndroid ? 'Android' : 'iOS',
    );
    await serviceApi.client.deviceRegister(
      deviceId: body.id,
      fcmToken: body.fcmToken ?? '',
      locale: LanguageController.currentLocale.toLanguageTag(),
      platform: body.platform ?? '',
    ).then(
      (response) {
        GeneralData.getInstance().setDeviceIsRegistered(true);
        GeneralData.getInstance().setIsChangedFCMToken(false);
      },
      onError: (error) {
      },
    );
  }

  Future<void> _updateDevice(String deviceId) async {
    final body = ModelRequestDeviceUpdate(
      fcmToken: GeneralData.getInstance().getFCMToken(),
      ipAddress: await printIps(),
      latitude: 0,
      longitude: 0,
    );
    await serviceApi.client.deviceUpdate(deviceId, body).then(
      (response) {
        GeneralData.getInstance().setDeviceIsRegistered(true);
        GeneralData.getInstance().setIsChangedFCMToken(false);
      },
      onError: (error) {
      },
    );
  }
}
