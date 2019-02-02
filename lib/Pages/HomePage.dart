import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Pages/CheatCodesMenuPage.dart';
import 'package:rdr2/Pages/GuidePage.dart';
import 'package:rdr2/Pages/SettingsPage.dart';
import 'package:rdr2/Resorces/AppColor.dart';
import 'package:rdr2/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = new StreamController();

    BlocProvider.myBanner
      ..load()
      ..show(anchorOffset: 60.0);
  }

  @override
  void dispose() {
    _streamController.close();
    BlocProvider.myBanner.dispose();
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
              "HOME",
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return new CheatCodesMenuPage();
                              },
                            ),
                          );
                        },
                        color: AppColor.red,
                        width: 320.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "RED DEAD",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          color: Colors.black87,
                                          blurRadius: 6.0,
                                          offset: Offset(2.5, 2.5),
                                        )
                                      ],
                                      color: Colors.white,
                                      fontSize: 42.0,
                                      wordSpacing: -4.0,
                                      letterSpacing: -1.0),
                                ),
                                Text(
                                  "REDEMPTION",
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black87,
                                        blurRadius: 6.0,
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    color: Colors.white,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ],
                            ),
                            buildSeparator(),
                            buildSeparator(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "CHEAT",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          color: Colors.black87,
                                          blurRadius: 6.0,
                                          offset: Offset(2.5, 2.5),
                                        )
                                      ],
                                      color: Colors.white,
                                      fontSize: 36.0,
                                      wordSpacing: -4.0,
                                      letterSpacing: -1.0),
                                ),
                                Text(
                                  "CODE",
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black87,
                                        blurRadius: 6.0,
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    color: Colors.white,
                                    fontSize: 36.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        width: 320.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomButton(
                              color: AppColor.yellow,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Icons/Home/buffalo.png"),
                                              fit: BoxFit.contain),
                                        ),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 80.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(pi),
                                                child: Image.asset(
                                                  "Icons/Home/horse.png",
                                                  height: 52.0,
                                                ),
                                              ),
                                              Image.asset(
                                                "Icons/Home/gun.png",
                                                height: 52.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Guides",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GuidePage()));
                              },
                            ),
                            CustomButton(
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsPage()));
                              },
                              color: AppColor.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Icons/Home/setting.png"),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Settings",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
        MyDrawer(_changePage, _streamController.stream),
      ],
    );
  }

  void _changePage(String page) {
    _streamController.add(false);
    switch (page) {
      case "CHEAT CODES":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheatCodesMenuPage()));
        break;
      case "GUIDES":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GuidePage()));
        break;
      case "RATE US":
        break;
      case "SHARE":
        break;
    }
  }

  Padding buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 8.0,
      ),
      child: Container(
        width: 8.0,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 6.0,
            offset: Offset(2.5, 2.5),
          )
        ]),
      ),
    );
  }
}
