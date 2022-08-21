// import 'dart:ui';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_flutter/carousel.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:portfolio_flutter/carousel.dart';
// import 'package:portfolio_flutter/footer.dart';
import 'package:portfolio_flutter/interfaces/projects.dart';
import 'package:portfolio_flutter/projects.dart';
import 'package:portfolio_flutter/summary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:float_column/float_column.dart';
import 'package:email_validator/email_validator.dart';

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
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey();
  final entryPageKey = GlobalKey();
  final summaryPageKey = GlobalKey();
  final projectsPageKey = GlobalKey();
  final contactPageKey = GlobalKey();

  final formKey = GlobalKey<FormState>();

  String title = 'Summary';

  final double customToolbarHeight = 60;

  late AnimationController controller;

  final RegExp emailRegex = RegExp('');

  Future<Projects> readJson() async {
    Map<String, dynamic> data =
        json.decode(await rootBundle.loadString('json/projects.json'));
    return Projects.fromJson(data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      key: scaffoldKey,
      body: FutureBuilder(
          future: readJson(),
          builder: (BuildContext context, AsyncSnapshot<Projects> snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      key: entryPageKey,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.green,
                      child: Center(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        constraints:
                            const BoxConstraints(minWidth: 260, minHeight: 260),
                        child: Center(
                          child: ElevatedButton(
                              onPressed: () => {
                                    Scrollable.ensureVisible(
                                      summaryPageKey.currentContext!,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  },
                              child: const Text('Summary')),
                        ),
                      )),
                    ),
                  ),
                  SliverAppBar(
                    title: Text(title, style: TextStyle(fontSize: 26)),
                    toolbarHeight: customToolbarHeight,
                    snap: false,
                    floating: false,
                    pinned: true,
                    actions: MediaQuery.of(context).size.width > 480
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                  onPressed: () => {
                                        Scrollable.ensureVisible(
                                          summaryPageKey.currentContext!,
                                          duration: const Duration(seconds: 1),
                                        ),
                                        setState(() => title = 'Summary'),
                                      },
                                  child: const Text('Summary')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                  onPressed: () => {
                                        Scrollable.ensureVisible(
                                          projectsPageKey.currentContext!,
                                          duration: const Duration(seconds: 1),
                                        ),
                                        setState(() => title = 'Projects')
                                      },
                                  child: const Text('Projects')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                  onPressed: () => {
                                        Scrollable.ensureVisible(
                                          contactPageKey.currentContext!,
                                          duration: const Duration(seconds: 1),
                                        ),
                                        setState(() => title = 'Contact')
                                      },
                                  child: const Text('Contact')),
                            ),
                          ]
                        : [
                            IconButton(
                                onPressed: () => {
                                      Scrollable.ensureVisible(
                                        summaryPageKey.currentContext!,
                                        duration: const Duration(seconds: 1),
                                      ),
                                      setState(() => title = 'Summary'),
                                    },
                                icon: const Icon(Icons.account_box_rounded,
                                    color: Colors.green,
                                    size: 24.0,
                                    semanticLabel: 'Text to announce')),
                            IconButton(
                                onPressed: () => {
                                      Scrollable.ensureVisible(
                                        projectsPageKey.currentContext!,
                                        duration: const Duration(seconds: 1),
                                      ),
                                      setState(() => title = 'Projects')
                                    },
                                icon: const Icon(Icons.co_present_rounded,
                                    color: Colors.green,
                                    size: 24.0,
                                    semanticLabel: 'Text to announce')),
                            IconButton(
                                onPressed: () => {
                                      Scrollable.ensureVisible(
                                        contactPageKey.currentContext!,
                                        duration: const Duration(seconds: 1),
                                      ),
                                      setState(() => title = 'Contact')
                                    },
                                icon: const Icon(Icons.mail_outline_rounded,
                                    color: Colors.green,
                                    size: 24.0,
                                    semanticLabel: 'Text to announce'))
                          ],
                  ),
                  SliverToBoxAdapter(
                      // key: const Key('summaryPageBox'),
                      key: summaryPageKey,
                      child: MySummary(
                          key: const Key('summary-key'),
                          customToolbarHeight: customToolbarHeight)),
                  SliverToBoxAdapter(
                    child: Container(
                      key: projectsPageKey,
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          customToolbarHeight,
                      child: Center(
                        child: Carousel(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      key: contactPageKey,
                      color: Colors.yellow,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          customToolbarHeight,
                      child: Center(
                          child: Container(
                        height: Adaptive.h(50),
                        width: Adaptive.w(80),
                        color: Colors.red,
                        constraints: const BoxConstraints(
                            minWidth: 260, maxWidth: 400, maxHeight: 400),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formKey,
                            child: Column(children: [
                              // TODO: TextFormField researchm & submit & database-integration & automatic email generation
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Vorname Nachname',
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Telefonnummer',
                                ),
                              ),
                              TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'E-Mail Addresse',
                                  ),
                                  validator: ((String? email) {
                                    if (email != null) {
                                      return email.isNotEmpty &&
                                              EmailValidator.validate(email)
                                          ? null
                                          : 'This E-Mail isn\'t valid';
                                    } else {
                                      return 'Please enter your E-Mail';
                                    }
                                  })),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        formKey.currentState!.validate(),
                                    child: Text('submit')),
                              )
                            ]),
                          ),
                        ),
                      )),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
}
