import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../utils/custom_icons_icons.dart';

class AboutAppListTile extends StatelessWidget {
  Future<void> launchUrl(BuildContext context, String url) async {
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Could not open URL'),
          content: Text(url + ' could not be opened'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('GOT IT'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      icon: const Icon(Icons.info),
      child: const Text('About'),
      applicationIcon: Image.asset(
        'assets/icon/launcher_icon.png',
        height: 75,
        width: 75,
      ),
      applicationLegalese: 'Made by Chiedozie Divine',
      applicationVersion: 'v0.5.2',
      aboutBoxChildren: <Widget>[
      ],
    );
  }
}
