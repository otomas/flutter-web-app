import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_route.dart';
import 'widget_button.dart';
import 'widget_image.dart';
import 'widgets_text.dart';

class ScrollWithNoGlowWidget extends StatelessWidget {
  const ScrollWithNoGlowWidget({
    required this.child,
    super.key,
    this.isActiveScroll = true,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.primary,
  });
  final Widget child;
  final bool isActiveScroll;
  final Axis scrollDirection;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool? primary;

  @override
  Widget build(BuildContext context) => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: isActiveScroll
            ? SingleChildScrollView(
                primary: primary,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: padding,
                controller: controller,
                scrollDirection: scrollDirection,
                physics: physics,
                child: child,
              )
            : child,
      );
}

class ScrollWithAnimation extends StatefulWidget {
  const ScrollWithAnimation({
    this.children,
    this.builder,
    super.key,
    this.imagePath,
    this.padding,
    this.imageHeroTag,
    this.aspectRatio = 3 / 4,
    this.appBarBackText,
    this.isActiveScroll = true,
    this.onBackPressed,
    this.appBarAction,
  });

  final List<Widget>? children;
  final Widget? Function()? builder;
  final String? imagePath;
  final EdgeInsets? padding;
  final String? imageHeroTag;
  final double aspectRatio;
  final String? appBarBackText;
  final bool isActiveScroll;
  final Function()? onBackPressed;
  final Widget? appBarAction;

  @override
  State<ScrollWithAnimation> createState() => _ScrollWithAnimationState();
}

class _ScrollWithAnimationState extends State<ScrollWithAnimation> with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // final Duration _duration = const Duration();
  // final Tween<Offset> _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
  // late double min = 0.9;
  // late double initial = 0.9;
  // late double max = 0.9;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this, duration: _duration);
    // _controller.forward();

    // if (widget.aspectRatio == 3 / 4) {
    //   min = 0.9; //0.6;
    //   initial = 0.9; //0.8;
    // } else {
    //   min = 0.9; //0.75;
    //   initial = 0.9; //0.75;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: double.infinity,
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: GestureDetector(
              onTap: () async {
                if (widget.imagePath != null) {
                  // unawaited(
                  //   Provider.of<ServiceRoute>(context, listen: false)
                  //       .startNewView(route: RoutePhoto(urls: [widget.imagePath!], heroTag: widget.imageHeroTag ?? '')),
                  // );
                }
              },
              child: NetworkImageWithPlaceholder(
                height: 0,
                width: 0,
                imageUrl: widget.imagePath,
                isColorFilterActive: true,
              ),
            ),
          ),
        ),
        _getChild(null),
        //  SizedBox.expand(
        //         child: SlideTransition(
        //           position: _tween.animate(_controller),
        //           child: DraggableScrollableSheet(
        //             minChildSize: min,
        //             maxChildSize: max,
        //             initialChildSize: initial,
        //             builder: (context, controller) => AnimatedBuilder(
        //               animation: controller,
        //               builder: (context, child) => _getChild(controller),
        //             ),
        //           ),
        //         ),
        //       ),
      ],
    );
  }

  Widget _getChild(ScrollController? controller) => Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: ColoredBox(
            color: R.color.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.appBarBackText != null)
                      ButtonBasic(
                        onPressed: widget.onBackPressed ?? () => unawaited(Provider.of<ServiceRoute>(context, listen: false).onBackPressed()),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        bgColor: R.color.white,
                        fontFamily: R.fonts.displayRegular,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new, color: R.color.blue, size: 16),
                            const SizedBox(width: 4),
                            TextBasic(
                              text: widget.appBarBackText ?? '-',
                              color: R.color.blue,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    if (widget.appBarAction != null)
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: widget.appBarAction,
                        ),
                      ),
                  ],
                ),
                if (widget.appBarBackText != null) Container(height: 1, width: double.infinity, color: R.themeColor.borderLight.withOpacity(0.7)),
                if (widget.builder != null)
                  Expanded(
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        SliverFillRemaining(child: widget.builder!()),
                      ],
                    ),
                  )
                else if (widget.isActiveScroll)
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: widget.children?.length ?? 0,
                      padding: widget.padding ?? EdgeInsets.zero,
                      itemBuilder: (context, index) => widget.children![index],
                    ),
                  )
                else if (widget.children != null)
                  ...widget.children!,
              ],
            ),
          ),
        ),
      );
}
