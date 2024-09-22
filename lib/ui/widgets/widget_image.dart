import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/_r.dart';
import 'activity_indicator.dart';

class NetworkImageWithPlaceholder extends StatelessWidget {
  const NetworkImageWithPlaceholder({
    required this.height,
    required this.width,
    super.key,
    this.imageUrl,
    this.svgPath,
    this.placeholderPath,
    this.isColorFilterActive = false,
    this.isActiveShadow = false,
    this.isCircle = false,
    this.border,
    this.boxFit,
    this.radius,
    this.alignment = Alignment.center,
  });
  final String? imageUrl;
  final String? svgPath;
  final String? placeholderPath;
  final double width;
  final double height;
  final bool isColorFilterActive;
  final bool isActiveShadow;
  final bool isCircle;
  final BoxFit? boxFit;
  final BoxBorder? border;
  final double? radius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) => imageUrl == null
      ? svgPath != null
          ? SvgPicture.asset(svgPath!, height: height, width: width)
          : _getPlaceHolder()
      : (imageUrl?.contains('.svg') ?? false)
          ? ClipRRect(
              borderRadius: radius == null ? BorderRadius.zero : BorderRadius.circular(radius!),
              child: SvgPicture.network(
                imageUrl!,
                fit: boxFit ?? BoxFit.cover,
                height: height,
                width: width,
                placeholderBuilder: (context) => _getLoading(),
                // headers: Provider.of<ServiceApi>(context, listen: false).getHeaderData,
              ),
            )
          : Image.network(
              imageUrl!,
              fit: boxFit ?? BoxFit.cover,
              height: height,
              width: width,
              cacheWidth: 900,
              cacheHeight: 900,
              alignment: alignment,
              // headers: Provider.of<ServiceApi>(context, listen: false).getHeaderData,
              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : _getLoading(),
              errorBuilder: (context, error, stackTrace) {
                log(error.toString(), name: 'IMAGE ERROR');
                return _getPlaceHolder();
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: border,
                  color: R.themeColor.viewBg,
                  borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                  boxShadow: [
                    if (isActiveShadow)
                      BoxShadow(
                        color: R.color.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Container(
                  height: height,
                  width: width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
                    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    gradient: !isColorFilterActive
                        ? null
                        : LinearGradient(
                            colors: [
                              R.color.black.withOpacity(0.9),
                              R.color.transparent,
                              R.color.black.withOpacity(0.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5, 1],
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: isCircle ? BorderRadius.circular(width > height ? width : height) : BorderRadius.circular(radius ?? 0),
                    child: child,
                  ),
                ),
              ),
            );

  Widget _getLoading() => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: R.themeColor.border,
          borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(
          child: IOSIndicator(
            color: R.color.black,
          ),
        ),
      );

  Widget _getPlaceHolder() => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: R.themeColor.border,
          borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(child: Icon(Icons.photo, color: R.color.white)),
      );
}
