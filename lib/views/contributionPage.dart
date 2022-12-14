import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../CONSTANTS.dart' as Constants;
import '../utils/launchUrl.dart';

class ButtonContent {
  String label;
  Function onClick;
  ButtonContent(this.label, this.onClick);
}

class ContributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribution and Support'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                  'Alhamdulillah. Thank you for your interest in donating to the Malaysia Prayer Time app. May Allah SWT rewards your kindness.'),
              SizedBox(
                height: 8,
              ),
              MyCard(
                title: 'Share the app',
                description:
                    'Share your experience on using this app with your family and friends. Get the app on bit.ly/MPTdl',
                buttonContent: [
                  ButtonContent(
                      'Copy link',
                      () => Clipboard.setData(
                              ClipboardData(text: 'http://bit.ly/MPTdl'))
                          .then(
                              (value) => Fluttertoast.showToast(msg: 'Copied')))
                ],
              ),
              Divider(),
              MyCard(
                title: 'Buy me a coffee?',
                description:
                    'One cup of Nescafe is usually enough for me to code all night.\n\n${Constants.kBuyMeACoffeeLink.substring(12)}', //substring will remove 'https://www' stuffs.
                buttonContent: [
                  ButtonContent(
                    'Copy',
                    () => copyClipboard(Constants.kBuyMeACoffeeLink),
                  ),
                  ButtonContent('Open', () {
                    LaunchUrl.normalLaunchUrl(url: Constants.kBuyMeACoffeeLink);
                  })
                ],
              ),
              MyCard(
                title: 'Direct support',
                description:
                    '${Constants.kMaybankAccNo} - Muhammad Fareez Iqmal (Maybank)',
                buttonContent: [
                  ButtonContent(
                    'Copy',
                    () => copyClipboard(Constants.kMaybankAccNo),
                  ),
                ],
              ),
              MyCard(
                title: 'Contribute to source',
                description:
                    'MPT is open source. Report any bugs or contribute directly to the source code. It is licensed under GNU GPLv3.',
                buttonContent: [
                  ButtonContent(
                      'Copy', () => copyClipboard(Constants.kGithubRepoLink)),
                  ButtonContent(
                      'Open GitHub',
                      () => LaunchUrl.normalLaunchUrl(
                          url: Constants.kGithubRepoLink)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void copyClipboard(String url) {
    Clipboard.setData(ClipboardData(text: url))
        .then((value) => Fluttertoast.showToast(msg: 'Copied to clipboard'));
  }
}

class MyCard extends StatelessWidget {
  MyCard({Key key, this.title, this.description, this.buttonContent})
      : super(key: key);

  final String title;
  final String description;
  final List<ButtonContent> buttonContent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('\n$description'),
            ),
            buttonContent != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: buttonContent.map((item) {
                      return TextButton(
                        child: Text(item.label),
                        onPressed: item.onClick,
                      );
                    }).toList(),
                  )
                : SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
