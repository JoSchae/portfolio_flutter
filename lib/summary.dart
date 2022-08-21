import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_flutter/hexagon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum EAnimation {
  startAnimation;
}

class MySummary extends StatefulWidget {
  const MySummary({Key? key, required this.customToolbarHeight})
      : super(key: key);

  final double customToolbarHeight;

  @override
  State<MySummary> createState() => _MySummaryState();
}

class _MySummaryState extends State<MySummary> {
  StreamController<EAnimation> animationController =
      StreamController<EAnimation>.broadcast();

  double _barChartsWidth = 0;
  double _cardRotation = 0;
  bool _hasAnimated = false;

  @override
  void dispose() {
    animationController.close();
    super.dispose();
  }

  void _updateBarChartsWidth() =>
      Future.delayed(const Duration(seconds: 1), () {
        updateProgressData();
      });

  void updateProgressData() {
    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (_barChartsWidth < 0.8) {
        setState(() {
          _barChartsWidth = _barChartsWidth + 0.01;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void animateEverything() {
    updateProgressData();
  }

  void _startAnimations() {
    setState(() => _hasAnimated = true);
    animationController.sink.add(EAnimation.startAnimation);
    animateEverything();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('some-key'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visibilityInfo.visibleFraction == 1) {
          _startAnimations();
        }
        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - widget.customToolbarHeight,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.blueGrey,
              child: Center(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              MyHexagon(
                                animationController: animationController,
                                size: 20,
                                backgroundColor: Colors.amber,
                                iconData: Icons.account_tree_outlined,
                                iconColor: Colors.green,
                              ),
                              MyHexagon(
                                animationController: animationController,
                                size: 20,
                                backgroundColor: Colors.amber,
                                iconData: Icons.account_tree_outlined,
                                iconColor: Colors.green,
                              ),
                              MyHexagon(
                                animationController: animationController,
                                size: 20,
                                backgroundColor: Colors.amber,
                                iconData: Icons.account_tree_outlined,
                                iconColor: Colors.green,
                              ),
                              MyHexagon(
                                animationController: animationController,
                                size: 20,
                                backgroundColor: Colors.amber,
                                iconData: Icons.account_tree_outlined,
                                iconColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const Text('Angular')),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: LinearProgressIndicator(
                          value: _barChartsWidth,
                          semanticsLabel: 'Linear progress indicator',
                          minHeight: 20,
                          backgroundColor: Colors.grey,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class MyPolygon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(size.width * 1 / 9, size.height / 2),
      Offset(size.width * 2.7 / 9, size.height * 7.5 / 9),
      Offset(size.width * 6.3 / 9, size.height * 7.5 / 9),
      Offset(size.width * 8 / 9, size.height / 2),
      Offset(size.width * 6.3 / 9, size.height * 1.5 / 9),
      Offset(size.width * 2.7 / 9, size.height * 1.5 / 9)
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
