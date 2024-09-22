import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/extensions/extension_string.dart';

import '/core/resources/_r.dart';
import '/ui/widgets/widgets_text.dart';

class TextFieldBasic extends StatefulWidget {
  const TextFieldBasic({
    super.key,
    this.title,
    this.labelText,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.isPassword = false,
    this.isRequired = false,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.textColor,
    this.labelTextColor,
    this.labelTextFont,
    this.fontFamily,
    this.fontWeight = FontWeight.w700,
    this.hintText,
    this.fontSize,
    this.elevation = 0.0,
    this.suffixIcon,
    this.hasError = false,
    this.errorLabel,
    this.prefixIcon,
    this.bgColor,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWith = 1.0,
    this.radius = 12.0,
    this.textAlignVertical,
    this.textAlign,
    this.isDense,
    this.contentPaddingVertical,
    this.contentPaddingHorizontal,
    this.inputFormatters,
    this.titleSuffix,
    this.isActiveShadow = false,
    this.titleAlign,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.padding,
  });
  final String? title;
  final String? labelText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool isRequired;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final Color? textColor;
  final Color? labelTextColor;
  final String? labelTextFont;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final String? hintText;
  final double? fontSize;
  final double? elevation;
  final Widget? suffixIcon;
  final bool hasError;
  final String? errorLabel;
  final Widget? prefixIcon;
  final Color? bgColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderWith;
  final double radius;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final bool? isDense;
  final double? contentPaddingVertical;
  final double? contentPaddingHorizontal;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? titleSuffix;
  final bool isActiveShadow;
  final TextAlign? titleAlign;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final EdgeInsets? padding;

  @override
  State<TextFieldBasic> createState() => _TextFieldBasicState();
}

class _TextFieldBasicState extends State<TextFieldBasic> {
  late FocusNode focusNode;
  bool? obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
    focusNode = widget.focusNode ?? FocusNode();
  }

  void setObscureText() {
    obscureText = !obscureText!;
    notifyListener();
  }

  void notifyListener() => setState(() {});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title == null)
            Container()
          else
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Expanded(
                    child: RichTextBasic(
                      textAlign: widget.titleAlign ?? TextAlign.start,
                      texts: ((widget.isRequired ? '* ' : '') + widget.title!).highlightOccurrences(
                        '* ',
                        textColor: R.themeColor.smoke,
                        boldTextColor: R.color.candy,
                        boldFontSize: 14,
                        fontSize: 14,
                        boldFont: R.fonts.displayBold,
                        font: R.fonts.displayBold,
                      ),
                    ),
                  ),
                  widget.titleSuffix ?? Container(),
                ],
              ),
            ),
          SizedBox(height: widget.title == null ? 0.0 : 5.0),
          DecoratedBox(
            decoration: BoxDecoration(
              color: widget.bgColor ?? R.color.transparent,
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: !widget.isActiveShadow
                  ? []
                  : [
                      BoxShadow(
                        blurRadius: 10,
                        color: R.color.black.withOpacity(0.12),
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 4),
              child: TextFormField(
                autofillHints: widget.autofillHints,
                textCapitalization: widget.textCapitalization,
                inputFormatters: widget.inputFormatters,
                enabled: widget.enabled ?? true,
                cursorColor: R.themeColor.primary,
                focusNode: focusNode,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                maxLength: widget.maxLength,
                onFieldSubmitted: widget.onFieldSubmitted,
                controller: widget.controller,
                obscureText: obscureText!,
                maxLines: widget.maxLines,
                validator: widget.validator,
                textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
                textAlign: widget.textAlign ?? TextAlign.start,
                style: TextStyle(
                  color: widget.textColor ?? R.themeColor.smokeDark,
                  fontSize: widget.fontSize ?? 16,
                  fontFamily: widget.fontFamily ?? R.fonts.displayRegular,
                  fontWeight: widget.fontWeight ?? FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: widget.fillColor ?? R.color.white,
                  isDense: widget.isDense ?? true,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.contentPaddingVertical ?? 16.0,
                    horizontal: widget.contentPaddingHorizontal ?? 14.0,
                  ),
                  labelText: widget.labelText,
                  labelStyle: TextStyle(
                    color: widget.labelTextColor ?? R.themeColor.smoke,
                    fontSize: 16,
                    fontFamily: widget.labelTextFont ?? R.fonts.displayRegular,
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: TextStyle(
                    color: widget.labelTextColor ?? R.themeColor.smoke,
                    fontSize: 16,
                    fontFamily: widget.labelTextFont ?? R.fonts.displayRegular,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: widget.suffixIcon ?? _getSuffixIcon(),
                  ),
                  suffixIconConstraints: const BoxConstraints(),
                  prefixIcon: widget.prefixIcon,
                  border: _getBorder(),
                  focusedBorder: _getFocusedBorder(),
                  enabledBorder: _getBorder(),
                  errorBorder: _getErrorBorder(),
                  focusedErrorBorder: _getBorder(),
                  disabledBorder: _getBorder(),
                ),
              ),
            ),
          ),
          if (widget.errorLabel != null)
            if (widget.hasError)
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: R.color.candy,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextBasic(
                        text: widget.errorLabel!,
                        color: R.color.candy,
                        fontFamily: R.fonts.displayRegular,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
        ],
      );

  OutlineInputBorder _getBorder() {
    if (widget.hasError) {
      return _getErrorBorder();
    }
    return OutlineInputBorder(
      borderSide: widget.borderWith == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.borderColor ?? R.themeColor.border,
              width: widget.borderWith,
            ),
      borderRadius: BorderRadius.circular(widget.radius),
    );
  }

  OutlineInputBorder _getFocusedBorder() {
    if (widget.hasError) {
      return _getErrorBorder();
    }
    return OutlineInputBorder(
      borderSide: widget.borderWith == 0
          ? BorderSide.none
          : BorderSide(
              color: widget.focusedBorderColor ?? widget.borderColor ?? R.themeColor.primary,
              width: widget.borderWith,
            ),
      borderRadius: BorderRadius.circular(widget.radius),
    );
  }

  OutlineInputBorder _getErrorBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.errorBorderColor ?? R.color.candy,
        ),
        borderRadius: BorderRadius.circular(widget.radius),
      );

  Widget? _getSuffixIcon() {
    if (widget.isPassword!) {
      return Container(
        height: 24,
        width: 24,
        margin: const EdgeInsets.only(bottom: 5, right: 8),
        child: IconButton(
          icon: Icon(
            obscureText! ? Icons.visibility_outlined : Icons.visibility_off,
            color: R.themeColor.primary,
          ),
          iconSize: 16,
          onPressed: setObscureText,
        ),
      );
    } else {
      return null;
    }
  }
}
