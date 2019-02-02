import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Model/CleatCode.dart';
import 'package:rdr2/Pages/CheatCodesMenuPage.dart';
import 'package:rdr2/Pages/CheatCodesPage.dart';
import 'package:rdr2/Pages/GuidePage.dart';
import 'package:rdr2/Resorces/AppColor.dart';
import 'package:rdr2/main.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  StreamController<bool> _streamController;
  AnimationController _dialogAnimationController;

  @override
  void initState() {
    super.initState();
    _streamController = new StreamController();
    _dialogAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _streamController.close();
    _dialogAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Color.fromRGBO(29, 30, 41, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(17, 18, 23, 1.0),
            title: Text(
              "SETTINGS",
              style: TextStyle(fontSize: 26.0),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 360.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _getButton(
                              "Icons/settings/youtube.png",
                              "DEMO VIDEO",
                              AppColor.red,
                              () {
                                _launchURL("https://youtu.be/GqGnbhn3QlM");
                              },
                            ),
                            _getButton(
                              "Icons/settings/share.png",
                              "SHARE THE APP",
                              AppColor.purple,
                              () {
                                _shareText(
                                  "https://play.google.com/store/apps/details?id=com.alephapps.reddeadcheats",
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 360.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _getButton(
                              "Icons/settings/like.png",
                              "RATE US",
                              AppColor.yellow,
                              () {
                                _launchURL(
                                    "https://play.google.com/store/apps/details?id=com.alephapps.reddeadcheats");
                              },
                            ),
                            _getButton(
                              "Icons/settings/play.png",
                              "MORE APP",
                              AppColor.green,
                              () {
                                _launchURL(
                                    "https://play.google.com/store/apps/developer?id=DevAlephApps");
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 360.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _getButton(
                              "Icons/settings/what.png",
                              "HOW TO USE",
                              AppColor.blue,
                              () {
                                _dialogAnimationController.forward();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.0,
                )
              ],
            ),
          ),
          bottomNavigationBar: new BottomBar(
            pageName: "ANIMALS",
            onMenuPressed: () {
              _streamController.add(true);
            },
          ),
        ),
        AnimatedBuilder(
          animation: _dialogAnimationController,
          builder: (context, child) {
            return FractionalTranslation(
              translation:
                  Offset(0.0, 1.0 * (1.0 - _dialogAnimationController.value)),
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              _dialogAnimationController.reverse();
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                  top: 36.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                decoration: BoxDecoration(
                    color: AppColor.deepGray,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 24.0,
                      )
                    ]),
                child: getDialogContainer(),
              ),
            ),
          ),
        ),
        MyDrawer(_changePage, _streamController.stream),
      ],
    );
  }

  _launchURL(String url) async {
    await launch(url);
  }

  Future _shareText(String text) async {
    var response = await FlutterShareMe().shareToSystem(
      msg: text,
    );
    if (response == 'success') {
      print('navigate success');
    }
  }

  Material getDialogContainer() {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "How To Use Red Dead Redemption 2 Cheat Codes ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.red,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "1) ",
              style: TextStyle(
                fontFamily: "Rock",
                color: AppColor.yellow,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "Press the Pause button in the game.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "2) ",
              style: TextStyle(
                fontFamily: "Rock",
                color: AppColor.yellow,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "Select the Settings Menu and Press Triangle ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "(PS4) ",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                  text: "or Y ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "(XBOX1) ",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: "to access the hidden cheat menu.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "3) ",
              style: TextStyle(
                fontFamily: "Rock",
                color: AppColor.yellow,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text:
                      "Then Enter the Red Dead 2 Cheat Codes IN CHEAT CODE SECTION.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          Text(
            "Important Note",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.red,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "By activating a cheat you lose the ability to save single player game progress, and collect single player trophies.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _changePage(String page) {
    _streamController.add(false);
    switch (page) {
      case "HOME":
        Navigator.popUntil(context, ModalRoute.withName("\/"));
        break;
      case "GUIDES":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GuidePage()));
        break;
      case "CHEAT CODES":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheatCodesMenuPage()));
        break;
      case "RATE US":
        break;
      case "SHARE":
        break;
    }
  }

  Widget _getButton(String image, String title, Color color, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110.0,
        width: 160.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image,
                height: 50.0,
                width: 50.0,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
