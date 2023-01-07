import 'package:flutter/widgets.dart';

class Utils {
  static bool isMobile() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 768;
  }
}
