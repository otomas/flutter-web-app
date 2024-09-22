import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/core/resources/_r.dart';
import '../base/base_view.dart';
import 'widgets_text.dart';

class ButtonBasic extends StatelessWidget with BaseView {
  const ButtonBasic({
    super.key,
    this.textBasic,
    this.bgColor,
    this.splashColor,
    this.disabledColor,
    this.radius = 14.0,
    this.elevation = 0.0,
    this.borderSide = BorderSide.none,
    this.onPressed,
    this.text,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.child,
    this.padding,
    this.minWidth,
  });
  final TextBasic? textBasic;
  final Color? bgColor;
  final Color? splashColor;
  final Color? disabledColor;
  final double radius;
  final double? elevation;
  final BorderSide borderSide;
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Widget? child;
  final EdgeInsets? padding;
  final double? minWidth;

  @override
  Widget build(BuildContext context) => MaterialButton(
        mouseCursor: SystemMouseCursors.click,
        hoverColor: splashColor,
        highlightColor: splashColor,
        splashColor: splashColor,
        highlightElevation: 0,
        hoverElevation: 0,
        minWidth: minWidth,
        elevation: elevation,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        ),
        color: bgColor ?? R.themeColor.primary,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: isWeb(context) ? 20 : size(context).shortestSide * 0.04,
              vertical: isWeb(context) ? size(context).shortestSide * 0.025 : 16,
            ),
        disabledColor: disabledColor,
        onPressed: onPressed,
        child: textBasic ??
            child ??
            TextBasic(
              text: text ?? '',
              color: textColor ?? R.themeColor.viewBg,
              fontFamily: fontFamily ?? R.fonts.displayBold,
              fontSize: fontSize ?? 14.0,
              fontWeight: fontWeight,
            ),
      );
}

class ButtonPremium extends StatelessWidget {
  const ButtonPremium({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: R.color.yellow,
        ),
        child: TextBasic(text: R.string.premium, color: R.color.brown, fontFamily: R.fonts.displayBold, fontSize: 10),
      );
}

class DropdownButtonBasic<T> extends StatelessWidget {
  const DropdownButtonBasic({
    required this.item,
    required this.itemTitle,
    required this.isSelected,
    required this.isActiveBorder,
    required this.onSelected,
    super.key,
  });
  final T item;
  final String itemTitle;
  final bool isSelected;
  final bool isActiveBorder;
  final Function(T) onSelected;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onSelected(item),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            border: isActiveBorder ? Border(bottom: BorderSide(color: R.themeColor.secondaryLight)) : null,
            color: R.color.white,
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? R.color.primarySwatch : R.color.black.withOpacity(0.3)),
                ),
                child: Center(
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: isSelected ? R.color.primarySwatch : R.color.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextBasic(
                  text: itemTitle.replaceAll('&amp;', '&'),
                  color: isSelected ? R.color.primarySwatch : R.color.black,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    required this.onPressed,
    super.key,
    this.bgColor,
    this.iconColor,
    this.iconPath,
    this.iconSvgPath,
    this.size = 40.0,
    this.iconSize = 24.0,
    this.icon,
  });
  final Color? bgColor;
  final Color? iconColor;
  final String? iconPath;
  final String? iconSvgPath;
  final double? size;
  final double? iconSize;
  final Widget? icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bgColor ?? R.color.white,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            icon: icon != null
                ? icon!
                : iconPath == null
                    ? iconSvgPath == null
                        ? Container()
                        : SvgPicture.asset(
                            iconSvgPath!,
                            colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                            width: iconSize,
                            height: iconSize,
                          )
                    : Image.asset(
                        iconPath!,
                        color: iconColor,
                        width: iconSize,
                        height: iconSize,
                      ),
          ),
        ),
      );
}

class WidgetUtilsButton extends StatelessWidget {
  const WidgetUtilsButton({
    required this.color,
    required this.title,
    required this.description,
    required this.onPressed,
    this.isExpanded = false,
    super.key,
  });
  final Color color;
  final String title;
  final String description;
  final Function() onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) => isExpanded ? Expanded(child: _getContent()) : _getContent();

  Widget _getContent() => InkWell(
        splashColor: R.color.transparent,
        hoverColor: R.color.transparent,
        focusColor: R.color.transparent,
        highlightColor: R.color.transparent,
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBasic(text: title, color: R.themeColor.secondary, fontFamily: R.fonts.displayBold, fontSize: 14),
                    const SizedBox(height: 10),
                    TextBasic(text: description, color: R.themeColor.secondary, fontSize: 12),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: R.themeColor.secondary),
            ],
          ),
        ),
      );
}

class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton({required this.onPressed, super.key, this.bgColor, this.iconColor, this.radius = 8.0});
  final Color? bgColor;
  final Color? iconColor;
  final double radius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            iconSize: 16,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back,
              color: iconColor ?? R.themeColor.primary,
            ),
            onPressed: onPressed,
          ),
        ),
      );
}

class WidgetOptionIconButton extends StatelessWidget {
  const WidgetOptionIconButton({required this.svgPath, required this.onPressed, super.key});

  final String svgPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        focusColor: R.color.transparent,
        hoverColor: R.color.transparent,
        splashColor: R.color.transparent,
        highlightColor: R.color.transparent,
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: R.themeColor.boxBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(child: SvgPicture.asset(svgPath, height: 20, width: 20)),
        ),
      );
}

class WidgetFilterRemoveButton extends StatelessWidget {
  const WidgetFilterRemoveButton({required this.title, required this.onPressed, super.key});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        splashColor: R.color.transparent,
        focusColor: R.color.transparent,
        hoverColor: R.color.transparent,
        highlightColor: R.color.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: R.themeColor.borderLight),
          ),
          child: Wrap(
            children: [
              TextBasic(
                text: title,
                color: R.themeColor.secondaryHover,
                fontFamily: R.fonts.displayMedium,
                fontSize: 12,
              ),
              Container(width: 10),
              SvgPicture.asset(R.drawable.svg.iconRemove),
            ],
          ),
        ),
      );
}
