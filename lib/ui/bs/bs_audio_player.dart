import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;

import '../../core/resources/_r.dart';

class BSAudioPlayer extends StatefulWidget {

  const BSAudioPlayer({
    required this.source, super.key,
    this.onDelete,
    this.isSelected,
  });
  /// Path from where to play recorded audio
  final ap.AudioSource source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback? onDelete;
  final bool? isSelected;

  @override
  BSAudioPlayerState createState() => BSAudioPlayerState();
}

class BSAudioPlayerState extends State<BSAudioPlayer> {
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  @override
  void initState() {
    _playerStateChangedSubscription = _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription = _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription = _audioPlayer.durationStream.listen((duration) => setState(() {}));
    unawaited(_init());

    super.initState();
  }

  Future<void> _init() async {
      await _audioPlayer.setAudioSource(widget.source);
  }

  @override
  void dispose() {
    unawaited(_playerStateChangedSubscription.cancel());
    unawaited(_positionChangedSubscription.cancel());
    unawaited(_durationChangedSubscription.cancel());
    unawaited(_audioPlayer.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildControl(),
                  Expanded(child: _buildSlider(constraints.maxWidth)),
                  if (widget.onDelete != null) IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: R.themeColor.warning,
                            size: _deleteBtnSize,
                          ),
                          onPressed: () {
                            unawaited(_audioPlayer.stop().then((value) => widget.onDelete!()));
                            Navigator.pop(context);
                          },
                        ) else Container(),
                ],
              ),
          ),
        ),
      ],
    );

  Widget _buildControl() {
    Icon icon;
    Color color;

    if (_audioPlayer.playerState.playing) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (_audioPlayer.playerState.playing) {
              unawaited(pause());
            } else {
              unawaited(play());
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    var canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    var width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return SizedBox(
      width: width,
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).primaryColor,
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            unawaited(_audioPlayer.seek(Duration(milliseconds: position.round())));
          }
        },
        value: canSetValue && duration != null ? position.inMilliseconds / duration.inMilliseconds : 0.0,
      ),
    );
  }

  Future<void> play() => _audioPlayer.play();

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration());
  }
}
