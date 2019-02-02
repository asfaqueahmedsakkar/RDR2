import 'package:flutter/material.dart';
import 'package:rdr2/BlockProvider.dart';
import 'package:rdr2/Pages/HomePage.dart';
import 'package:rdr2/Pages/SettingsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Red Dead Redumtion',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Rock"),
        home: MyHomePage(title: 'HOME'),
        routes: {
          "home": (context) => MyHomePage(
                title: "HOME",
              ),
        },
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Function(String) onChange;
  final Stream<bool> controller;

  MyDrawer(this.onChange, this.controller);

  @override
  MyDrawerState createState() {
    return new MyDrawerState(controller);
  }
}

class MyDrawerState extends State<MyDrawer> {
  Stream<bool> controller;

  MyDrawerState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: controller,
      initialData: false,
      builder: (context, snapShot) {
        if (!snapShot.data) return SizedBox();
        return GestureDetector(
          onTap: drawerToggle,
          child: Container(
            color: Colors.black54,
            alignment: Alignment.centerLeft,
            child: Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  width: 220.0,
                  color: Colors.white,
                  child: Theme(
                    data: ThemeData(
                        primarySwatch: Colors.blue, fontFamily: "Rock"),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 24.0,
                        ),
                        new DrawerItem(
                          icon: "Icons/drawer/home.png",
                          title: "HOME",
                          onPress: widget.onChange,
                        ),
                        new DrawerItem(
                          icon: "Icons/drawer/gamecheat.png",
                          title: "CHEAT CODES",
                          onPress: widget.onChange,
                        ),
                        new DrawerItem(
                          icon: "Icons/drawer/guide.png",
                          title: "GUIDES",
                          onPress: widget.onChange,
                        ),
                        new DrawerItem(
                          icon: "Icons/drawer/favorite.png",
                          title: "RATE US",
                          onPress: widget.onChange,
                        ),
                        new DrawerItem(
                          icon: "Icons/drawer/share.png",
                          title: "SHARE",
                          onPress: widget.onChange,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  drawerToggle() {
    widget.onChange(null);
  }
}

class DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function(String) onPress;

  const DrawerItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.pressed();
        onPress(title);
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              icon,
              height: 30.0,
              width: 30.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 26.0, fontFamily: "Rock"),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function onClick;
  final Color color;
  final Widget child;
  final double height, width;

  CustomButton(
      {this.color,
      this.child,
      this.height = 120.0,
      this.width = 140.0,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.pressed();
        if (onClick != null) onClick();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            /*image: DecorationImage(
                image: AssetImage("Icons/Bottom Bar/menu.png"),
                fit: BoxFit.contain),*/
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.6),
                offset: Offset(0.0, 10.0),
              ),
            ]),
        child: child ?? SizedBox(),
      ),
    );
  }
}
