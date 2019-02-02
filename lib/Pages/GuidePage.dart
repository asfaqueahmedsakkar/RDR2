import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Pages/AnimalsPage.dart';
import 'package:rdr2/Pages/CheatCodesMenuPage.dart';
import 'package:rdr2/Pages/GuideDetailsListPage.dart';
import 'package:rdr2/Resorces/AppColor.dart';
import 'package:rdr2/main.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = new StreamController();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _commonStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black87,
          blurRadius: 6.0,
          offset: Offset(2.5, 2.5),
        )
      ],
      color: Colors.white,
      fontSize: 42.0,
    );

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Color.fromRGBO(29, 30, 41, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(17, 18, 23, 1.0),
            title: Text(
              "GUIDES",
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
                      CustomButton(
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuideDetailsListPage(
                                        title: "rifle".toUpperCase(),
                                        guilesForItems: BlocProvider.weapons,
                                      )));
                        },
                        color: AppColor.yellow,
                        width: 320.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Image.asset(
                                      "Icons/Guide Categories/rifle.png"),
                                  Transform(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                        "Icons/Guide Categories/rifle.png"),
                                    transform: Matrix4.rotationY(pi),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Transform.rotate(
                              angle: pi * .05,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "BEST",
                                          style: _commonStyle,
                                        ),
                                        SizedBox(
                                          width: 16.0,
                                        ),
                                        _trophyImage(),
                                      ],
                                    ),
                                    Text(
                                      "WEAPONS",
                                      style: _commonStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      CustomButton(
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuideDetailsListPage(
                                        title: "HORSES",
                                        guilesForItems: BlocProvider.horses,
                                      )));
                        },
                        color: AppColor.green,
                        width: 320.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Transform.rotate(
                              angle: -pi * .05,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _trophyImage(),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "BEST",
                                          style: _commonStyle,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "HORSES",
                                      style: _commonStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                  "Icons/Guide Categories/horse.png"),
                            )
                          ],
                        ),
                      ),
                      CustomButton(
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimalsPage()));
                        },
                        color: AppColor.magenta,
                        width: 320.0,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                  "Icons/Guide Categories/buffalo.png"),
                            ),
                            Expanded(
                                child: Transform.rotate(
                              angle: pi * .04,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "ANIMALS",
                                      style: _commonStyle,
                                    ),
                                    Text(
                                      "HOW TO KILL?\nWHAT TO USE?",
                                      style: TextStyle(
                                        color: AppColor.orrange,
                                        fontSize: 26.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
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
        MyDrawer(_changePage, _streamController.stream),
      ],
    );
  }

  void _changePage(String page) {
    _streamController.add(false);
    switch (page) {
      case "HOME":
        Navigator.popUntil(context, ModalRoute.withName("\/"));
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

  Stack _trophyImage() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.translate(
          child: Image.asset(
            "Icons/Guide Categories/trophy.png",
            height: 40.0,
            color: Colors.black12,
            colorBlendMode: BlendMode.srcIn,
          ),
          offset: Offset(1.0, 1.0),
        ),
        Image.asset(
          "Icons/Guide Categories/trophy.png",
          height: 36.0,
        ),
      ],
    );
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
