import 'package:flutter/material.dart';
import '/core/models/model_flavor.dart';

class FlavorConfig {

  factory FlavorConfig({
    required String flavorName,
    required ModelFlavor values, bool bannerEnabled = true,
    Color bannerColor = Colors.pink,
    Color textColor = Colors.white,
  }) {
    // ignore: join_return_with_assignment
    _instance = FlavorConfig._internal(
      flavorName,
      bannerEnabled,
      bannerColor,
      textColor,
      values,
    );

    return _instance;
  }

  FlavorConfig._internal(
    this.flavorName,
    this.bannerEnabled,
    this.bannerColor,
    this.textColor,
    this.values,
  );
  /// The name of the flavor.
  final String flavorName;

  /// Determines if the banner should be shown.
  final bool bannerEnabled;

  /// The color of the banner if enabled.
  final Color bannerColor;

  /// The color of the text inside the banner if enabled.
  final Color textColor;

  /// The values that belong to the flavor.
  final ModelFlavor values;

  static late FlavorConfig _instance;

  static FlavorConfig get instance => _instance;

  /// Gets the name of the flavor.
  static String getFlavorName() => _instance.flavorName;

  /// Returns `true` if the banner will be shown.
  static bool isBannerEnabled() => _instance.bannerEnabled;

  /// Gets the color of the banner if enabled.
  static Color getBannerColor() => _instance.bannerColor;

  /// Gets the color of the text inside the banner if enabled.
  static Color getTextColor() => _instance.textColor;
}

class FlavorBanner extends StatelessWidget {

  const FlavorBanner({required this.child, super.key, 
    this.navigatorKey,
  });
  /// The [GlobalKey<NavigatorState>] for when the [FlavorBanner] in not in a context with
  /// that includes a [Navigator].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The child where the banner should be rendered on top of.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!FlavorConfig.isBannerEnabled()) {
      return child;
    }

    return Stack(
      children: <Widget>[
        child,
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPress: () {
            context = navigatorKey?.currentState?.overlay?.context ?? context;
          },
          child: CustomPaint(
            painter: BannerPainter(
              message: FlavorConfig.getFlavorName().toUpperCase(),
              textDirection: Directionality.of(context),
              layoutDirection: Directionality.of(context),
              location: BannerLocation.topStart,
              color: FlavorConfig.getBannerColor(),
              textStyle: TextStyle(
                color: FlavorConfig.getTextColor(),
                fontSize: 12.0 * 0.85,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
