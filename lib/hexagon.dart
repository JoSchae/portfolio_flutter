import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_flutter/summary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHexagon extends StatefulWidget {
  MyHexagon(
      {Key? key,
      required this.animationController,
      required this.size,
      required this.backgroundColor,
      IconData? this.iconData,
      MaterialColor? this.iconColor})
      : super(key: key);

  final StreamController<EAnimation> animationController;
  final double size;
  final Color backgroundColor;
  IconData? iconData;
  Color? iconColor;

  @override
  State<MyHexagon> createState() => _MyHexagonState();
}

class _MyHexagonState extends State<MyHexagon> {
  double _cardRotation = 0;
  StreamSubscription<EAnimation>? animationEventSubscription;

  @override
  void initState() {
    super.initState();
    animationEventSubscription = widget.animationController.stream.asBroadcastStream().listen((event) {
      if (event == EAnimation.startAnimation) {
        updateCardRotation();
      }
    });
  }

  void updateCardRotation() {
    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (_cardRotation < 1) {
        setState(() {
          _cardRotation = _cardRotation + 0.02;
        });
      } else {
        _cardRotation = 1;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0)
        ..rotateY(_cardRotation < 0.5 ? _cardRotation * pi : (1 + _cardRotation) * pi),
      alignment: FractionalOffset.center,
      child: ClipPath(
        clipper: MyPolygon(),
        child: Container(
            width: Adaptive.w(widget.size),
            height: Adaptive.w(widget.size),
            color: widget.backgroundColor,
            constraints: const BoxConstraints(minWidth: 120, minHeight: 120),
            child: _cardRotation < 0.5
                ? Icon(widget.iconData ?? Icons.alarm, color: widget.iconColor, size: 50, semanticLabel: 'Text to announce')
                : IconButton(
                    onPressed: () => print('clicked'),
                    padding: EdgeInsets.zero,
                    icon: Image.asset(
                      '/images/IMG-20170107-WA0004.jpg',
                      fit: BoxFit.cover,
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
