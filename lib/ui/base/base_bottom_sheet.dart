import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import '/core/resources/_r.dart';
import 'base_view.dart';

class BottomSheetBase extends StatelessWidget with BaseView {
  const BottomSheetBase({required this.child, required this.isActiveKeyboardPadding, super.key});
  final Widget child;
  final bool isActiveKeyboardPadding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomBarHeight = !isActiveKeyboardPadding ? 0.0 : (systemPadding(context).bottom + viewInsets(context).bottom);
    return GestureDetector(
      onTap: () => router(context).hideKeyboard(context),
      child: Stack(
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(bottom: bottomBarHeight, top: 16),
            constraints: BoxConstraints(
              maxHeight: size.height * 0.9,
              minHeight: size.height * 0.2,
            ),
            decoration: BoxDecoration(
              color: R.color.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: child,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: kIsWeb ? Container() : Divider(color: R.themeColor.border, height: 5, endIndent: 162, indent: 162, thickness: 5),
          ),
        ],
      ),
    );
  }
}
