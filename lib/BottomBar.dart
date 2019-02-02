import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';

class BottomBar extends StatefulWidget {
  final String pageName;
  final Function() onMenuPressed;

  const BottomBar({Key key, this.pageName, @required this.onMenuPressed})
      : super(key: key);

  @override
  BottomBarState createState() {
    return new BottomBarState();
  }
}

class BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(17, 18, 23, 1.0),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              onPressed: () {
                BlocProvider.pressed();
                widget.onMenuPressed();
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Image.asset("Icons/Bottom Bar/menu.png"),
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {
                BlocProvider.pressed();
                Navigator.popUntil(context, ModalRoute.withName("\/"));
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Image.asset("Icons/Bottom Bar/house.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
