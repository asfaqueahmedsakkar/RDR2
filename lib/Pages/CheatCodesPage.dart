import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Model/CleatCode.dart';
import 'package:rdr2/Pages/CheatCodesMenuPage.dart';
import 'package:rdr2/Pages/GuidePage.dart';
import 'package:rdr2/Resorces/AppColor.dart';
import 'package:rdr2/main.dart';

class CheatCodePage extends StatefulWidget {
  final String title;
  final List<CheatCode> cheatCodes;

  CheatCodePage({@required this.title, @required this.cheatCodes});

  @override
  CheatCodePageState createState() {
    return new CheatCodePageState();
  }
}

class CheatCodePageState extends State<CheatCodePage> {
  List<int> currentExpandedItem;
  StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    currentExpandedItem = new List();
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
              "${widget.title}",
              style: TextStyle(fontSize: 26.0),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return currentExpandedItem.contains(index)
                          ? ExpandedCheatCodeWidget(
                              onPress: () {
                                setState(() {
                                  currentExpandedItem.remove(index);
                                });
                              },
                              cheatCode: widget.cheatCodes[index])
                          : TitleWidget(
                              onPress: () {
                                setState(() {
                                  currentExpandedItem.add(index);
                                });
                              },
                              title: widget.cheatCodes[index].title);
                    },
                    itemCount: widget.cheatCodes.length,
                  ),
                ),
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
}

class TitleWidget extends StatelessWidget {
  final Function onPress;
  final String title;

  TitleWidget({this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black87,
                  blurRadius: 2.0,
                  offset: Offset(0.5, 0.5),
                )
              ],
              color: Colors.white,
              fontSize: 28.0,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(164, 23, 23, 1.0),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 8.0,
              )
            ]),
      ),
    );
  }
}

class ExpandedCheatCodeWidget extends StatelessWidget {
  final Function onPress;
  final CheatCode cheatCode;

  ExpandedCheatCodeWidget({this.onPress, this.cheatCode});

  @override
  Widget build(BuildContext context) {
    TextStyle commonStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black87,
          blurRadius: 2.0,
          offset: Offset(0.5, 0.5),
        )
      ],
      color: Colors.white,
      fontSize: 24.0,
    );
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8.0,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(12.0),
              child: Text(
                cheatCode.title,
                style: TextStyle(shadows: [
                  Shadow(
                    color: Colors.black87,
                    blurRadius: 2.0,
                    offset: Offset(0.5, 0.5),
                  )
                ], color: Colors.white, fontSize: 28.0, letterSpacing: 0.0),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(164, 23, 23, 1.0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: AppColor.gray,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      "EFFECT",
                      style: commonStyle,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "CODE",
                      style: commonStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColor.deepGray,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                        cheatCode.requirement.isEmpty ? 16.0 : 0.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      cheatCode.effect,
                      style: commonStyle.copyWith(
                        color: Color.fromRGBO(164, 23, 23, 1.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      cheatCode.code,
                      style: commonStyle.copyWith(
                        color: Color.fromRGBO(164, 23, 23, 1.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            cheatCode.requirement.isEmpty
                ? SizedBox()
                : Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(75, 78, 98, 1.0),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "REQUIRMENT",
                          style: commonStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(41, 44, 59, 1.0),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(16.0))),
                        child: Text(
                          cheatCode.requirement,
                          style: commonStyle.copyWith(
                            color: Color.fromRGBO(164, 23, 23, 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
