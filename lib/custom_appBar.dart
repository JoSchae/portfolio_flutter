import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_flutter/util/util.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      required this.summaryPageKey,
      required this.projectsPageKey,
      required this.contactPageKey,
      required this.toolbarHeight,
      required this.titleAddition});

  final GlobalKey summaryPageKey;
  final GlobalKey projectsPageKey;
  final GlobalKey contactPageKey;
  final double toolbarHeight;
  String titleAddition = '';

  bool isMobile = false;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: !Utils.isMobile()
            ? Container(
                child: Wrap(
                children: [Text('Schäfer Development - ${widget.titleAddition}')],
              ))
            : Container(),
        // toolbarHeight: widget.toolbarHeight,
        actions: Utils.isMobile()
            ? [
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.account_box_rounded, color: Colors.green, size: 24.0, semanticLabel: 'Text to announce')),
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.co_present_rounded, color: Colors.green, size: 24.0, semanticLabel: 'Text to announce')),
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.mail_outline_rounded, color: Colors.green, size: 24.0, semanticLabel: 'Text to announce'))
              ]
            : [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () => {
                            // Scrollable.ensureVisible(
                            //   widget.summaryPageKey.currentContext!,
                            //   duration: const Duration(seconds: 1),
                            // ),
                            setState(() => widget.titleAddition = 'Summary'),
                          },
                      child: const Text('Summary')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () => {
                            // Scrollable.ensureVisible(
                            //   widget.projectsPageKey.currentContext!,
                            //   duration: const Duration(seconds: 1),
                            // ),
                            setState(() => widget.titleAddition = 'Projects')
                          },
                      child: const Text('Projects')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () => {
                            // Scrollable.ensureVisible(
                            //   widget.contactPageKey.currentContext!,
                            //   duration: const Duration(seconds: 1),
                            // ),
                            setState(() => widget.titleAddition = 'Contact')
                          },
                      child: const Text('Contact')),
                ),
              ]);
  }
}
