import 'package:flutter/widgets.dart';
import '../card_swiper.dart';
import 'flutter_page_indicator/flutter_page_indicator.dart';

/// plugin to display swiper components
///
abstract class SwiperPlugin {
  const SwiperPlugin();

  Widget build(BuildContext context, SwiperPluginConfig config);
}

class SwiperPluginConfig {
  final Axis scrollDirection;
  final SwiperController controller;
  final int activeIndex;
  final int itemCount;
  final PageIndicatorLayout? indicatorLayout;
  final bool loop;
  final bool? outer;
  final PageController? pageController;
  final SwiperLayout? layout;

  const SwiperPluginConfig({
    required this.scrollDirection,
    required this.controller,
    required this.activeIndex,
    required this.itemCount,
    this.indicatorLayout,
    this.outer,
    this.pageController,
    this.layout,
    this.loop = false,
  });
}

class SwiperPluginView extends StatelessWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView({
    Key? key,
    required this.plugin,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return plugin.build(context, config);
  }
}
