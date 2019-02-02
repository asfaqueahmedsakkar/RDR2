import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';
import 'package:rdr2/BottomBar.dart';
import 'package:rdr2/Model/CleatCode.dart';
import 'package:rdr2/Pages/CheatCodesPage.dart';
import 'package:rdr2/Pages/GuidePage.dart';
import 'package:rdr2/Resorces/AppColor.dart';
import 'package:rdr2/main.dart';

class CheatCodesMenuPage extends StatefulWidget {
  CheatCodesMenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CheatCodesMenuPageState createState() => _CheatCodesMenuPageState();
}

class _CheatCodesMenuPageState extends State<CheatCodesMenuPage> {
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
              "CHEAT CODES",
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
                        width: 320.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _getButton(
                              "Icons/Cheat Code Categories/bullets.png",
                              BlocProvider.cheatCodes.keys
                                  .toList()[0]
                                  .toUpperCase(),
                              AppColor.red,
                              BlocProvider.cheatCodes[
                                  BlocProvider.cheatCodes.keys.toList()[0]],
                            ),
                            _getButton(
                              "Icons/Cheat Code Categories/energy.png",
                              "POWER UP",
                              Color.fromRGBO(106, 7, 78, 1.0),
                              BlocProvider.cheatCodes[
                                  BlocProvider.cheatCodes.keys.toList()[1]],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 320.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _getButton(
                              "Icons/Cheat Code Categories/worldwide.png",
                              "WORLD",
                              Color.fromRGBO(18, 15, 67, 1.0),
                              BlocProvider.cheatCodes[
                                  BlocProvider.cheatCodes.keys.toList()[2]],
                            ),
                            _getButton(
                              "Icons/Cheat Code Categories/placeholder.png",
                              "SPAWN",
                              AppColor.green,
                              BlocProvider.cheatCodes[
                                  BlocProvider.cheatCodes.keys.toList()[3]],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 320.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _getButton(
                              "Icons/Cheat Code Categories/unlock.png",
                              "UNLOCK",
                              AppColor.yellow,
                              BlocProvider.cheatCodes[
                                  BlocProvider.cheatCodes.keys.toList()[4]],
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

  Widget _getButton(
      String image, String title, Color color, List<CheatCode> cheatCode) {
    return CustomButton(
      onClick: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheatCodePage(
                      title: title,
                      cheatCodes: cheatCode,
                    )));
      },
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.contain),
                ),
              ),
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
    );
  }
}
