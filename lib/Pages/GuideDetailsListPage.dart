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

class GuideDetailsListPage extends StatefulWidget {
  final String title;
  final Map<String, List<String>> guilesForItems;

  GuideDetailsListPage({@required this.title, @required this.guilesForItems});

  @override
  GuideDetailsListPageState createState() {
    return new GuideDetailsListPageState();
  }
}

class GuideDetailsListPageState extends State<GuideDetailsListPage> {
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
                      String title = widget.guilesForItems.keys.toList()[index];
                      return currentExpandedItem.contains(index)
                          ? ExpandedGuideWidget(
                              onPress: () {
                                setState(() {
                                  currentExpandedItem.remove(index);
                                });
                              },
                              title: title,
                              subItems: widget.guilesForItems[title])
                          : TitleWidget(
                              onPress: () {
                                setState(() {
                                  currentExpandedItem.add(index);
                                });
                              },
                              title:
                                  widget.guilesForItems.keys.toList()[index]);
                    },
                    itemCount: widget.guilesForItems.length,
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
        new MyDrawer(_changePage, _streamController.stream),
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

class ExpandedGuideWidget extends StatelessWidget {
  final Function onPress;
  final List<String> subItems;
  final String title;

  ExpandedGuideWidget({this.title, this.onPress, this.subItems});

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
                title,
                style: TextStyle(shadows: [
                  Shadow(
                    color: Colors.black87,
                    blurRadius: 2.0,
                    offset: Offset(0.5, 0.5),
                  )
                ], color: Colors.white, fontSize: 28.0, letterSpacing: 0.0),
              ),
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColor.deepGray,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16.0)),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: subItems
                      .map(
                        (data) => Text(
                              data,
                              textAlign: TextAlign.center,
                              style: commonStyle.copyWith(
                                color: AppColor.red,
                              ),
                            ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
