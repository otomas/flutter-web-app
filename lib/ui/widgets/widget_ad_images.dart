import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/models/model_photo.dart';
import '../../core/resources/_r.dart';
import 'widget_image.dart';
import 'widget_scroll.dart';
import 'widgets_text.dart';

class WidgetAdImages extends StatefulWidget {
  const WidgetAdImages({required this.data, super.key});

  final List<ModelPhoto> data;

  @override
  State<WidgetAdImages> createState() => _WidgetAdImagesState();
}

class _WidgetAdImagesState extends State<WidgetAdImages> {
  final PageController _pageController = PageController();
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    if (index < widget.data.length - 1) {
      index = index + 1;
      setState(() {});
      unawaited(_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear));
    } else if (index == widget.data.length - 1) {
      index = 0;
      setState(() {});
      unawaited(_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear));
    }
  }

  void selectedPage(int index) {
    this.index = index;
    setState(() {});
    unawaited(_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear));
  }

  void previousPage() {
    if (index > 0) {
      index = index - 1;
      setState(() {});
      unawaited(_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear));
    } else if (index == 0) {
      index = widget.data.length - 1;
      setState(() {});
      unawaited(_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear));
    }
  }

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (index) {
                      this.index = index;
                      setState(() {});
                    },
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final item = widget.data[index];
                      return NetworkImageWithPlaceholder(
                        height: 300,
                        radius: 12,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: item.originalUrl,
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 20,
                    child: Center(
                      child: GestureDetector(
                        onTap: nextPage,
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: R.themeColor.smoke.withOpacity(0.2),
                          ),
                          child: Icon(Icons.keyboard_arrow_right, color: R.themeColor.viewBg),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 20,
                    child: Center(
                      child: GestureDetector(
                        onTap: previousPage,
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: R.themeColor.smoke.withOpacity(0.2),
                          ),
                          child: Icon(Icons.keyboard_arrow_left, color: R.themeColor.viewBg),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(visible: false, child: TextBasic(text: '${index + 1}/${widget.data.length}', color: R.themeColor.secondary, fontSize: 16)),
                        const Expanded(child: SizedBox(width: 20)),
                        ...List.generate(
                          widget.data.length,
                          (index) => AnimatedContainer(
                            height: 12,
                            width: this.index == index ? 34 : 12,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: this.index == index ? R.themeColor.secondary : R.themeColor.secondary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 20)),
                        Visibility(visible: widget.data.isNotEmpty , child: TextBasic(text: '${index + 1}/${widget.data.length}', color: R.themeColor.secondary, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ScrollWithNoGlowWidget(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.data.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: R.themeColor.secondary.withOpacity(0.25), offset: const Offset(0, 4)),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => selectedPage(index),
                        child: NetworkImageWithPlaceholder(
                          height: 60,
                          width: 120,
                          imageUrl: widget.data[index].originalUrl,
                          radius: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
