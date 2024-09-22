import 'package:flutter/material.dart';
import '../../core/resources/_r.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

class WidgetInfoCard extends StatefulWidget {
  const WidgetInfoCard({
    this.width,
    super.key,
    this.title,
    this.description,
    this.icon,
    this.crossButtonVisibility = false,
    this.bgColor,
    this.startColor,
    this.endColor,
    this.iconColor,
    this.onButtonAction,
    this.buttonText,
    this.isDescHighlighted,
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final bool crossButtonVisibility;
  final Color? bgColor;
  final Color? startColor;
  final Color? endColor;
  final double? width;
  final Function()? onButtonAction;
  final String? buttonText;
  final bool? isDescHighlighted;

  @override
  State<WidgetInfoCard> createState() => _WidgetInfoCardState();
}

class _WidgetInfoCardState extends State<WidgetInfoCard> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: 180,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: (widget.startColor == null || widget.endColor == null) ? widget.bgColor : null,
        gradient: widget.startColor != null && widget.endColor != null ? LinearGradient(colors: [widget.startColor!, widget.endColor!]) : null,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.icon != null) Container(margin: const EdgeInsets.all(20), child: Icon(widget.icon, color: widget.iconColor, size: 56)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title != null) TextBasic(text: widget.title ?? '', fontSize: 24, fontWeight: FontWeight.bold, color: R.color.black),
                    const SizedBox(height: 15),
                    if (widget.description != null)
                      DecoratedBox(
                        decoration: BoxDecoration(color: widget.isDescHighlighted != null ? R.themeColor.highlightedHover : Colors.transparent),
                        child: TextBasic(text: widget.description ?? '', fontSize: 18, color: R.color.black),
                      ),
                  ],
                ),
              ),
              if (widget.onButtonAction != null)
                ButtonBasic(
                  bgColor: R.themeColor.primary,
                  text: widget.buttonText,
                  textColor: R.color.white,
                  onPressed: widget.onButtonAction,
                  radius: 32,
                  minWidth: 160,
                ),
            ],
          ),
          if (widget.crossButtonVisibility)
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: widget.iconColor ?? R.themeColor.secondary),
                onPressed: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
