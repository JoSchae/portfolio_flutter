// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_flutter/carousel.dart';
import 'package:portfolio_flutter/footer.dart';
import 'package:portfolio_flutter/interfaces/projects.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:float_column/float_column.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _projects = [];

  // Future<List<ProjectModel>> readJson() async {
  //   // final String _response = await rootBundle.loadString('json/projects.json');
  //   // var data = jsonDecode(_response)['projects'] as List;
  //   // List<ProjectModel> projects =
  //   //     data.map((item) => ProjectModel.fromJson(item)).toList();

  //   // setState(() {
  //   //   _projects = data['projects'];
  //   // });
  //   // print(projects[0]);
  //   // setState(() {
  //   //   _projects = projects;
  //   // });
  //   final String response = await rootBundle.loadString('json/projects.json');
  //   Map<String, dynamic> projectsMap = jsonDecode(response);
  //   var projects = ProjectModel.fromJson(projectsMap) as List<ProjectModel>;
  //   _projects = projects;
  //   return projects;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await readJson();
  //   });
  // }

  int _counter = 0;
  final Widget svgIcon = SvgPicture.asset(
    "images/man-developing-website-on-desk.svg",
    semanticsLabel: "man developing website on desk.",
    fit: BoxFit.scaleDown,
  );

  final Widget image = Image.asset(
    "images/man-developing-website-on-desk.jpg",
    semanticLabel: "man developing website on desk.",
    fit: BoxFit.contain,
  );

  Widget networkImage = Image.network('https://picsum.photos/200/300');

  final headerOne = 'H1 Überschrift';
  final paragraph =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final summaryKey = GlobalKey();
  final carouselKey = GlobalKey();
  final floatingTextKey = GlobalKey();

  // TODO
// <a href="https://iconscout.com/illustrations/man" target="_blank">Man developing website on desk Illustration</a> by <a href="https://iconscout.com/contributors/woobrodesign" target="_blank">WOOBRO LTD</a>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 6,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(6),
                child: ElevatedButton(
                    onPressed: () =>
                        Scrollable.ensureVisible(summaryKey.currentContext!),
                    child: const Text('Summary')),
              ),
              Container(
                margin: const EdgeInsets.all(6),
                child: ElevatedButton(
                    onPressed: () =>
                        Scrollable.ensureVisible(carouselKey.currentContext!),
                    child: const Text('Carousel')),
              ),
              Container(
                margin: const EdgeInsets.all(6),
                child: ElevatedButton(
                    onPressed: () => Scrollable.ensureVisible(
                        floatingTextKey.currentContext!),
                    child: const Text('Floating Text')),
              ),
            ],
          )),
      body: FutureBuilder(
          future: readJson(),
          builder: (context, AsyncSnapshot<Projects> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Card(
                      //   child: Wrap(
                      //     alignment: WrapAlignment.center,
                      //     spacing: 10,
                      //     runSpacing: 6,
                      //     direction: Axis.horizontal,
                      //     // mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => Scrollable.ensureVisible(
                      //                 summaryKey.currentContext!),
                      //             child: const Text('Summary')),
                      //       ),
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => Scrollable.ensureVisible(
                      //                 carouselKey.currentContext!),
                      //             child: const Text('Carousel')),
                      //       ),
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => Scrollable.ensureVisible(
                      //                 floatingTextKey.currentContext!),
                      //             child: const Text('Floating Text')),
                      //       ),
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => null,
                      //             child: const Text('Button')),
                      //       ),
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => null,
                      //             child: const Text('Button')),
                      //       ),
                      //       Container(
                      //         margin: const EdgeInsets.all(6),
                      //         child: ElevatedButton(
                      //             onPressed: () => null,
                      //             child: const Text('Button')),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: Adaptive.w(50),
                        height: 30.h,
                        child: svgIcon,
                      ),
                      Container(
                        key: summaryKey,
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    headerOne,
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Carousel(key: carouselKey),
                      Container(
                        key: floatingTextKey,
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: FloatColumn(
                          children: [
                            Floatable(
                                float: FCFloat.start,
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration:
                                      const BoxDecoration(color: Colors.red),
                                  child: const Text('box1'),
                                )),
                            Floatable(
                              float: FCFloat.end,
                              clear: FCClear.both,
                              clearMinSpacing: 20,
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration:
                                    const BoxDecoration(color: Colors.blue),
                                child: const Text('box2'),
                              ),
                            ),
                            WrappableText(
                                text: TextSpan(
                                    text: (paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph +
                                        paragraph))),
                          ],
                        ),
                      ),
                      Text(snapshot.data!.projects[0].company),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Footer()
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<Projects> readJson() async {
    Map<String, dynamic> data =
        json.decode(await rootBundle.loadString('json/projects.json'));
    print(data);
    print(data['projects'][0]['company']);
    print(Projects.fromJson(data).projects[0].skills[0].name);
    return Projects.fromJson(data);
    // setState(() {
    //   _projects = data;
    // });
  }
}
