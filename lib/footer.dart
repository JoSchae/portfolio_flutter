import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);
  static Uri uri = Uri.parse('https://www.github.com');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Row(
        children: [
          Column(
            children: [
              Card(
                  child: Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse('https://github.com'),
                      builder: (context, followLink) => ElevatedButton(
                          onPressed: followLink, child: const Text('Github')))),
            ],
          )
        ],
      )),
    );
  }

  Future<void> _openLink(link) async {
    if (await canLaunchUrl(link.url)) {
      await launchUrl(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
