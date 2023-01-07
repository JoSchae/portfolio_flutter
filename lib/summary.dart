import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_flutter/hexagon.dart';
import 'package:portfolio_flutter/util/util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:percent_indicator/percent_indicator.dart';

enum EAnimation {
  startAnimation;
}

class MySummary extends StatefulWidget {
  const MySummary({Key? key, required this.customToolbarHeight}) : super(key: key);

  final double customToolbarHeight;

  @override
  State<MySummary> createState() => _MySummaryState();
}

class _MySummaryState extends State<MySummary> {
  StreamController<EAnimation> animationController = StreamController<EAnimation>.broadcast();

  double _angularBarChartsWidth = 0;
  double _javaBarChartsWidth = 0;
  double _javascriptBarChartsWidth = 0;

//   double _cardRotation = 0;
  bool _hasAnimated = false;

  @override
  void dispose() {
    animationController.close();
    super.dispose();
  }

  void _updateBarChartsWidth() => Future.delayed(const Duration(seconds: 1), () {
        updateProgressData();
      });

  void updateProgressData() {
    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (_angularBarChartsWidth < 0.8) {
        setState(() {
          _angularBarChartsWidth = _angularBarChartsWidth + 0.01;
        });
      } else {
        timer.cancel();
      }
    });
    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (_javaBarChartsWidth < 0.7) {
        setState(() {
          _javaBarChartsWidth = _javaBarChartsWidth + 0.01;
        });
      } else {
        timer.cancel();
      }
    });
    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (_javascriptBarChartsWidth < 0.9) {
        setState(() {
          _javascriptBarChartsWidth = _javascriptBarChartsWidth + 0.01;
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
        debugPrint('Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: Container(
        color: Colors.blue,
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height - widget.customToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.8,
            // height: MediaQuery.of(context).size.height * 0.8,
            child: Container(
                color: Colors.blueGrey,
                child: Utils.isMobile()
                    ? Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Angular')),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      constraints: const BoxConstraints(maxWidth: 100),
                                      child: LinearProgressIndicator(
                                        value: _angularBarChartsWidth,
                                        semanticsLabel: 'Linear progress indicator',
                                        minHeight: 20,
                                        backgroundColor: Colors.grey,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Java')),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      constraints: const BoxConstraints(maxWidth: 100),
                                      child: LinearProgressIndicator(
                                        value: _javaBarChartsWidth,
                                        semanticsLabel: 'Linear progress indicator',
                                        minHeight: 20,
                                        backgroundColor: Colors.grey,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Javascript')),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      constraints: const BoxConstraints(maxWidth: 100),
                                      child: LinearProgressIndicator(
                                        value: _javascriptBarChartsWidth,
                                        semanticsLabel: 'Linear progress indicator',
                                        minHeight: 20,
                                        backgroundColor: Colors.grey,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.all(12),
                            // width: Adaptive.w(35),
                            child: Text(
                              'Bacon ipsum dolor amet tail rump turkey, t-bone sausage prosciutto alcatra pork belly chislic strip steak jerky cupim ground round. Beef beef ribs pancetta, leberkas alcatra bresaola meatloaf brisket. Pig fatback meatloaf tongue picanha shoulder turkey meatball tri-tip beef ribs flank landjaeger. Porchetta pork belly tenderloin, chuck beef strip steak turducken tongue rump fatback biltong doner shank meatball pastrami.Frankfurter short loin pork strip steak, boudin jowl ham hamburger porchetta kevin. Fatback hamburger ribeye, boudin cupim shoulder pork belly ham hock swine strip steak cow pig beef ribs tri-tip pork loin. Pork drumstick pork belly t-bone ham hock. Bresaola picanha shank short loin, doner ham hock biltong flank turkey filet mignon shankle kielbasa.Jowl rump tail corned beef cow beef ribs cupim meatloaf turducken spare ribs. Swine drumstick ball tip, brisket pastrami boudin salami porchetta flank picanha tongue bacon. Cupim pork short loin bacon, filet mignon pork loin salami kielbasa corned beef cow doner hamburger ham chuck. Jowl ground round doner, bacon turducken pork belly spare ribs beef. Burgdoggen beef shank, porchetta filet mignon strip steak rump. Beef doner pork belly brisket fatback porchetta. Venison biltong turducken, landjaeger short loin pork loin cow prosciutto meatloaf tri-tip.Jerky pork venison strip steak, pork belly biltong cow swine pig sirloin. Beef ribs andouille spare ribs fatback. Shoulder filet mignon doner, alcatra biltong swine boudin short loin pork belly cow frankfurter shankle. Pork loin spare ribs capicola porchetta bacon drumstick alcatra pork belly ball tip flank venison. Ribeye spare ribs bacon jerky cupim, doner beef ribs short loin drumstick boudin chicken cow sirloin.Burgdoggen cupim kielbasa beef ribs pastrami corned beef chislic shankle alcatra tongue tail buffalo chuck chicken. Corned beef prosciutto strip steak rump, pork loin pork shank sirloin shoulder beef ribs meatball buffalo tongue. Flank doner tail short ribs chicken brisket chislic hamburger. Kielbasa strip steak hamburger rump kevin, tongue brisket pork chop ham.',
                              //   style: TextStyle(fontSize: 15.dp)),
                            )),
                      ])
                    : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                // Wrap(
                                //   children: [
                                //     Text(
                                //         'Bacon ipsum dolor amet tail rump turkey, t-bone sausage prosciutto alcatra pork belly chislic strip steak jerky cupim ground round. Beef beef ribs pancetta, leberkas alcatra bresaola meatloaf brisket. Pig fatback meatloaf tongue picanha shoulder turkey meatball tri-tip beef ribs flank landjaeger. Porchetta pork belly tenderloin, chuck beef strip steak turducken tongue rump fatback biltong doner shank meatball pastrami.Frankfurter short loin pork strip steak, boudin jowl ham hamburger porchetta kevin. Fatback hamburger ribeye, boudin cupim shoulder pork belly ham hock swine strip steak cow pig beef ribs tri-tip pork loin. Pork drumstick pork belly t-bone ham hock. Bresaola picanha shank short loin, doner ham hock biltong flank turkey filet mignon shankle kielbasa.Jowl rump tail corned beef cow beef ribs cupim meatloaf turducken spare ribs. Swine drumstick ball tip, brisket pastrami boudin salami porchetta flank picanha tongue bacon. Cupim pork short loin bacon, filet mignon pork loin salami kielbasa corned beef cow doner hamburger ham chuck. Jowl ground round doner, bacon turducken pork belly spare ribs beef. Burgdoggen beef shank, porchetta filet mignon strip steak rump. Beef doner pork belly brisket fatback porchetta. Venison biltong turducken, landjaeger short loin pork loin cow prosciutto meatloaf tri-tip.Jerky pork venison strip steak, pork belly biltong cow swine pig sirloin. Beef ribs andouille spare ribs fatback. Shoulder filet mignon doner, alcatra biltong swine boudin short loin pork belly cow frankfurter shankle. Pork loin spare ribs capicola porchetta bacon drumstick alcatra pork belly ball tip flank venison. Ribeye spare ribs bacon jerky cupim, doner beef ribs short loin drumstick boudin chicken cow sirloin.Burgdoggen cupim kielbasa beef ribs pastrami corned beef chislic shankle alcatra tongue tail buffalo chuck chicken. Corned beef prosciutto strip steak rump, pork loin pork shank sirloin shoulder beef ribs meatball buffalo tongue. Flank doner tail short ribs chicken brisket chislic hamburger. Kielbasa strip steak hamburger rump kevin, tongue brisket pork chop ham.')
                                //   ],
                                // ),
                                Container(
                                    width: Adaptive.w(35),
                                    child: const Text(
                                      'Bacon ipsum dolor amet tail rump turkey, t-bone sausage prosciutto alcatra pork belly chislic strip steak jerky cupim ground round. Beef beef ribs pancetta, leberkas alcatra bresaola meatloaf brisket. Pig fatback meatloaf tongue picanha shoulder turkey meatball tri-tip beef ribs flank landjaeger. Porchetta pork belly tenderloin, chuck beef strip steak turducken tongue rump fatback biltong doner shank meatball pastrami.Frankfurter short loin pork strip steak, boudin jowl ham hamburger porchetta kevin. Fatback hamburger ribeye, boudin cupim shoulder pork belly ham hock swine strip steak cow pig beef ribs tri-tip pork loin. Pork drumstick pork belly t-bone ham hock. Bresaola picanha shank short loin, doner ham hock biltong flank turkey filet mignon shankle kielbasa.Jowl rump tail corned beef cow beef ribs cupim meatloaf turducken spare ribs. Swine drumstick ball tip, brisket pastrami boudin salami porchetta flank picanha tongue bacon. Cupim pork short loin bacon, filet mignon pork loin salami kielbasa corned beef cow doner hamburger ham chuck. Jowl ground round doner, bacon turducken pork belly spare ribs beef. Burgdoggen beef shank, porchetta filet mignon strip steak rump. Beef doner pork belly brisket fatback porchetta. Venison biltong turducken, landjaeger short loin pork loin cow prosciutto meatloaf tri-tip.Jerky pork venison strip steak, pork belly biltong cow swine pig sirloin. Beef ribs andouille spare ribs fatback. Shoulder filet mignon doner, alcatra biltong swine boudin short loin pork belly cow frankfurter shankle. Pork loin spare ribs capicola porchetta bacon drumstick alcatra pork belly ball tip flank venison. Ribeye spare ribs bacon jerky cupim, doner beef ribs short loin drumstick boudin chicken cow sirloin.Burgdoggen cupim kielbasa beef ribs pastrami corned beef chislic shankle alcatra tongue tail buffalo chuck chicken. Corned beef prosciutto strip steak rump, pork loin pork shank sirloin shoulder beef ribs meatball buffalo tongue. Flank doner tail short ribs chicken brisket chislic hamburger. Kielbasa strip steak hamburger rump kevin, tongue brisket pork chop ham.',
                                      //   style: TextStyle(fontSize: 15.dp)),
                                    ))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Angular')),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          constraints: const BoxConstraints(maxWidth: 100),
                                          child: LinearProgressIndicator(
                                            value: _angularBarChartsWidth,
                                            semanticsLabel: 'Linear progress indicator',
                                            minHeight: 20,
                                            backgroundColor: Colors.grey,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Java')),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          constraints: const BoxConstraints(maxWidth: 100),
                                          child: LinearProgressIndicator(
                                            value: _javaBarChartsWidth,
                                            semanticsLabel: 'Linear progress indicator',
                                            minHeight: 20,
                                            backgroundColor: Colors.grey,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: Adaptive.w(20), margin: const EdgeInsets.only(right: 20), child: const Text('Javascript')),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          constraints: const BoxConstraints(maxWidth: 100),
                                          child: LinearProgressIndicator(
                                            value: _javascriptBarChartsWidth,
                                            semanticsLabel: 'Linear progress indicator',
                                            minHeight: 20,
                                            backgroundColor: Colors.grey,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ])),
          ),
        ),
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
