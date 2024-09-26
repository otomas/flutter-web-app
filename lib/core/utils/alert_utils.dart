import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../ui/bs/bs_audio_recorder.dart';
import '../../ui/widgets/widget_button.dart';
import '../../ui/widgets/widgets_text.dart';
import '../constants/app_config.dart';
import '../enums/enum_app.dart' as enums;
import '../models/model_alert_dialog.dart';
import '../models/model_file.dart';
import '../resources/_r.dart';
import '../resources/strings.dart';
import '../services/service_device_info.dart';
import '../services/service_route.dart';
import '../settings/controller_language.dart';
import 'general_data.dart';
import 'permission_utils.dart';
import 'utilities.dart';

Future<void> showPlatformAlert(BuildContext context, ModelAlertDialog model, [Widget? child]) async {
  final result = await showDialog(
    context: context,
    barrierDismissible: model.isDismissible,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        padding: const EdgeInsets.all(20),
        color: R.themeColor.viewBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //SvgPicture.asset(model.dialogType != null ? model.dialogType.getSvg() : enums.DialogTypes.warning.getSvg(), width: 32, height: 32),
            TextBasic(
              text: model.title ?? 'Uyarı',
              fontFamily: R.fonts.displayBold,
              fontSize: 24,
            ),
            const SizedBox(height: 10),
            TextBasic(
              text: model.description,
              fontFamily: R.fonts.displayRegular,
              fontSize: 16,
            ),
            const SizedBox(height: 30),
            if (child != null) ...[
              child,
              const SizedBox(height: 30),
            ],
            Row(
              children: [
                if (model.isActiveCancelButton || model.dialogType == enums.DialogTypes.confirmation)
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: ButtonBasic(
                          text: R.string.cancel,
                          bgColor: model.buttonColor ?? R.themeColor.primary,
                          textColor: R.themeColor.smokeDark,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: ButtonBasic(
                    disabledColor: model.buttonColor ?? R.themeColor.primary,
                    bgColor: model.buttonColor ?? R.themeColor.primary,
                    text: model.buttonText ?? R.string.ok,
                    textColor: model.textColor,
                    onPressed: () {
                      Navigator.pop(context);
                      if (model.onPressedButton != null) {
                        model.onPressedButton?.call();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  if (result == OkCancelAlertDefaultType.ok && model.onPressedButton != null) {
    model.onPressedButton!();
  }
}

Future<void> showCloseAppAlert(BuildContext context, {ModelAlertDialog? model}) async {
  final serviceDeviceInfo = Provider.of<ServiceDeviceInfo>(context, listen: false);
  // ignore: unused_result
  await showAlertDialog(
    context: context,
    title: AppStrings.appName,
    message: model!.description,
    barrierDismissible: false,
    style: AdaptiveStyle.adaptive,
    actions: [AlertDialogAction(label: R.string.ok, key: OkCancelAlertDefaultType.ok, textStyle: TextStyle(color: R.themeColor.primary))],
  );

  try {
    await openStore(serviceDeviceInfo.appStoreId, serviceDeviceInfo.playStoreId);
  } on Exception catch (e) {
    log(e.toString(), name: 'STORE LAUNCH ERROR');
  }
  exit(0);
}

void showToast(String msg) {
  unawaited(
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: R.color.black,
      webBgColor: 'linear-gradient(to right, #384AD2, #9384AD2)',
      textColor: R.color.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    ),
  );
}

void hideSnackbar() {
  ServiceRoute.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
}

void showInSnackBar(String value, [Duration? duration]) {
  ServiceRoute.scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(value),
      showCloseIcon: false,
      closeIconColor: R.color.white,
      duration: duration ?? const Duration(seconds: 3),
    ),
  );
}

Future<List<ModelFile>> chooseFileSource(
  BuildContext context, {
  bool isActivePhoto = true,
  bool isActiveVideo = true,
  bool isActiveVoice = true,
  bool isActiveFile = true,
  bool isMulipleSelection = false,
  bool isActiveCameraUsage = true,
}) async {
  final files = <ModelFile>[];
  final fileType = await showCupertinoModalPopup<enums.FileType?>(
    context: context,
    builder: (context) => CupertinoTheme(
      data: const CupertinoThemeData(brightness: Brightness.dark),
      child: CupertinoActionSheet(
        actions: [
          if (isActivePhoto && isActiveCameraUsage)
            CupertinoActionSheetAction(
              child: Text(R.string.pickPhoto),
              onPressed: () => Navigator.pop(context, enums.FileType.camera),
            ),
          if (isActivePhoto)
            CupertinoActionSheetAction(
              child: Text(R.string.selectPhoto),
              onPressed: () => Navigator.pop(context, enums.FileType.gallery),
            ),
          if (isActiveVoice)
            CupertinoActionSheetAction(
              child: Text(R.string.voice),
              onPressed: () => Navigator.pop(context, enums.FileType.voice),
            ),
          if (isActiveFile)
            CupertinoActionSheetAction(
              child: Text(R.string.file),
              onPressed: () => Navigator.pop(context, enums.FileType.pdf),
            ),
          if (isActiveVideo && isActiveCameraUsage)
            CupertinoActionSheetAction(
              child: Text(R.string.pickVideo),
              onPressed: () => Navigator.pop(context, enums.FileType.videoCamera),
            ),
          if (isActiveVideo)
            CupertinoActionSheetAction(
              child: Text(R.string.selectVideo),
              onPressed: () => Navigator.pop(context, enums.FileType.videoGallery),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(R.string.cancel),
        ),
      ),
    ),
  );

  if (fileType != null) {
    final picker = ImagePicker();
    if (context.mounted) {
      if (fileType == enums.FileType.videoGallery) {
        if (context.mounted) {}
        if (await accessGalleryVideosPermission(context)) {
          final file = await picker.pickVideo(source: ImageSource.gallery);
          if (file != null) {
            final f = ModelFile(path: File(file.path).path, type: fileType, byte: await file.readAsBytes());
            files.add(f);
          }
        }
      } else if (fileType == enums.FileType.videoCamera) {
        if (await accessCameraPermission(context)) {
          final file = await picker.pickVideo(source: ImageSource.camera);
          if (file != null) {
            final f = ModelFile(path: File(file.path).path, type: fileType, byte: await file.readAsBytes());
            files.add(f);
          }
        }
      } else if (fileType == enums.FileType.camera) {
        if (await accessCameraPermission(context)) {
          final file = await picker.pickImage(source: ImageSource.camera);
          if (file != null) {
            final f = ModelFile(path: File(file.path).path, type: fileType, byte: await file.readAsBytes());
            files.add(f);
          }
        }
      } else if (fileType == enums.FileType.gallery) {
        if (await accessGalleryPermission(context)) {
          if (isMulipleSelection) {
            final f = await picker.pickMultiImage();
            for (final e in f) {
              files.add(ModelFile(path: File(e.path).path, type: fileType, byte: await e.readAsBytes()));
            }
          } else {
            final f = await picker.pickImage(source: ImageSource.gallery);
            if (f != null) {
              files.add(ModelFile(path: File(f.path).path, type: fileType, byte: await f.readAsBytes()));
            }
          }
        }
      } else if (fileType == enums.FileType.voice) {
        await Provider.of<ServiceRoute>(context, listen: false).showBaseBottomSheet(
          context,
          BsAudioRecorder(
            onSuccess: (file) {
              files.add(file);
            },
          ),
        );
      } else if (fileType == enums.FileType.pdf) {
        if (await accessStoragePermission(context)) {
          final result = await FilePicker.platform.pickFiles(allowedExtensions: allowedExtensions, type: FileType.custom, allowMultiple: isMulipleSelection);

          if (result != null) {
            for (final e in result.files) {
              if (e.path != null) {
                files.add(ModelFile(path: File(e.path!).path, type: fileType, byte: e.bytes));
              }
            }
          }
        }
      }
    }
  }
  return files;
}

Future<void> showCustomDatePicker(
  BuildContext context, {
  DateTime? initial,
  DateTime? min,
  DateTime? max,
  Function(DateTime, List<int>)? onConfirm,
}) async {
  if (kIsWeb) {
    final date = await showDatePicker(
      context: context,
      firstDate: min ?? GeneralData.getInstance().serverTime.add(const Duration(days: -365)),
      lastDate: max ?? GeneralData.getInstance().serverTime.add(const Duration(days: 365)),
      locale: LanguageController.currentLocale,
      initialDate: initial,
    );
    if (date != null) {
      onConfirm?.call(date, []);
    }
  } else {
    DatePicker.showDatePicker(
      context,
      initialDateTime: initial,
      minDateTime: min ?? GeneralData.getInstance().serverTime.add(const Duration(days: -365)),
      maxDateTime: max ?? GeneralData.getInstance().serverTime.add(const Duration(days: 365)),
      onConfirm: onConfirm,
      locale: LanguageController.datePickerLocale,
      dateFormat: 'dd MMMM yyyy',
      pickerTheme: DateTimePickerTheme(
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(width: 0.5, color: R.themeColor.border)),
          ),
        ),
        cancel: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextBasic(
            text: R.string.cancel,
            color: R.themeColor.primary,
            fontFamily: R.fonts.displayBold,
          ),
        ),
        confirm: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextBasic(
            text: R.string.ok,
            color: R.themeColor.primary,
            fontFamily: R.fonts.displayBold,
          ),
        ),
      ),
    );
  }
}

Future<void> showCustomTimePicker(
  BuildContext context, {
  DateTime? initial,
  DateTime? min,
  DateTime? max,
  Function(DateTime, List<int>)? onConfirm,
}) async {
  if (kIsWeb) {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial ?? GeneralData.getInstance().serverTime),
    );
    final currentDate = GeneralData.getInstance().serverTime;
    if (time != null) {
      onConfirm?.call(DateTime(currentDate.year, currentDate.month, currentDate.day, time.hour, time.minute), []);
    }
  } else {
    DatePicker.showDatePicker(
      context,
      initialDateTime: initial,
      minDateTime: min ?? GeneralData.getInstance().serverTime.add(const Duration(days: -365)),
      maxDateTime: max ?? GeneralData.getInstance().serverTime.add(const Duration(days: 365)),
      onConfirm: onConfirm,
      locale: LanguageController.datePickerLocale,
      pickerMode: DateTimePickerMode.time,
      dateFormat: 'HH:mm',
      pickerTheme: DateTimePickerTheme(
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(width: 0.5, color: R.themeColor.border)),
          ),
        ),
        cancel: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextBasic(
            text: R.string.cancel,
            color: R.themeColor.primary,
            fontFamily: R.fonts.displayBold,
          ),
        ),
        confirm: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextBasic(
            text: R.string.ok,
            color: R.themeColor.primary,
            fontFamily: R.fonts.displayBold,
          ),
        ),
      ),
    );
  }
}
