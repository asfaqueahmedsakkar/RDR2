import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Pages/CheatCodesMenuPage.dart';
import 'package:rdr2/Pages/GuidePage.dart';
import 'package:rdr2/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rdr2/Pages/GuideDetailsListPage.dart';
import 'package:rdr2/Resorces/AppColor.dart';

class AnimalsPage extends StatefulWidget {
  @override
  AnimalsPageState createState() {
    return new AnimalsPageState();
  }
}

class AnimalsPageState extends State<AnimalsPage> {
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
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Color.fromRGBO(29, 30, 41, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(17, 18, 23, 1.0),
            title: Text(
              "ANIMALS",
              style: TextStyle(fontSize: 26.0),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ExpandedGuideWidget(
                          title:
                              "The weapon you should use will depend on the animal size, this is because using the right weapon will increase the kill quality.",
                          subItems: [
                            "FOR MORE INFORMATION PLEASE REFER TO THE BUTTON BELOW"
                          ],
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: AppColor.red,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: Text("CLICK TO GO TO WEBSITE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0)),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            print("Called");
                          },
                          child: Text("Call"),
                        )
                      ],
                    )),
              ),
              Container(
                height: 50.0,
              )
            ],
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

  _launchURL() async {
    const url =
        'https://rankedboost.com/red-dead-redemption-2/hunting-wildlife-fishing/';
    await launch(url);
  }
}
