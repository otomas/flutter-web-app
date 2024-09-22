import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/resources/_r.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: R.color.black.withOpacity(0.04),
              ),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: R.color.black.withOpacity(0.04),
          ),
          child: Center(child: _getActivityIndicator()),
        ),
      ],
    );
  }

  Widget _getActivityIndicator() {
    if (kIsWeb) {
      return const IOSIndicator();
    }
    if (Platform.isAndroid) {
      return const AndroidIndicator();
    } else {
      return const IOSIndicator();
    }
  }
}

class AndroidIndicator extends StatelessWidget {
  const AndroidIndicator({super.key, this.color, this.strokeWidth = 4.0});
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color ?? R.color.white.withOpacity(0.7)),
        strokeWidth: strokeWidth,
      );
}

class IOSIndicator extends StatelessWidget {
  const IOSIndicator({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => CupertinoActivityIndicator(color: color);
}
