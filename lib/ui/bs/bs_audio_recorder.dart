import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

// ignore: library_prefixes
import '../../core/enums/enum_app.dart' as appEnum;
import '../../core/models/model_file.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/utils/permission_utils.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widgets_text.dart';

class BsAudioRecorder extends StatefulWidget {
  const BsAudioRecorder({
    required this.onSuccess,
    super.key,
  });

  final Function(ModelFile file) onSuccess;

  @override
  State<BsAudioRecorder> createState() => _BsAudioRecorderState();
}

class _BsAudioRecorderState extends WidgetBaseStatefull<BsAudioRecorder, VmBsAudioRecorder> {
  ModelFile? file;
  appEnum.ActivityState loadingState = appEnum.ActivityState.isLoaded;

  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;

  @override
  void dispose() {
    unawaited(audioRecorder.dispose());
    isRecording = false;
    super.dispose();
  }

  void setLoadingState(appEnum.ActivityState state) {
    loadingState = state;
    setState(() {});
  }

  Future<void> startRecord() async {
    if (await accessMicrophonePermission(context)) {
      if (await audioRecorder.hasPermission()) {
        final f = File('${(await getApplicationDocumentsDirectory()).path}/${DateTime.now().toIso8601String()}.m4a');
        await f.create(recursive: true);
        await audioRecorder.start(
          const RecordConfig(numChannels: 1, encoder: AudioEncoder.wav),
          path: f.path,
        );
        isRecording = true;
        setState(() {});
      }
    }
  }

  Future<void> stopRecord() async {
    final path = await audioRecorder.stop();
    if (path != null) {
      final record = ModelFile(path: path, type: appEnum.FileType.voice);
      file = record;
      widget.onSuccess(file!);
    }
    isRecording = false;
    setState(() {});

    if (context.mounted) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  VmBsAudioRecorder createViewModel(BuildContext context) => VmBsAudioRecorder(apiService(context));

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsAudioRecorder viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsAudioRecorder viewModel) => Padding(
        padding: viewInsets(context) + const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(
                  text: R.string.recordVoice,
                  color: R.color.black,
                  fontSize: 20,
                  fontFamily: R.fonts.displayBold,
                ),
                const SizedBox(height: 20),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      if (!isRecording) {
                        unawaited(startRecord());
                      } else {
                        unawaited(stopRecord());
                      }
                    },
                    backgroundColor: R.themeColor.primary,
                    child: Icon(isRecording ? Icons.pause : Icons.play_arrow, color: R.themeColor.viewBg),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size(context).width,
                  child: ButtonBasic(
                    text: R.string.ok,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class VmBsAudioRecorder extends ViewModelBase {
  VmBsAudioRecorder(this.serviceApi);

  final ServiceApi serviceApi;

  @override
  void init() {}
}
