import 'dart:async';

import "package:flutter/widgets.dart";
import 'package:rdr2/Model/CleatCode.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';

class BlocProvider extends InheritedWidget {
  static Map<String, List<String>> horses = new Map();
  static Map<String, List<String>> weapons = new Map();
  static Map<String, List<CheatCode>> cheatCodes = new Map();

  final String _appId = "ca-app-pub-6245553460179561~9621293246";

  final String _bannerId = "ca-app-pub-6245553460179561/1834959107";
  final String _inst1Id = "ca-app-pub-6245553460179561/4979997194";
  final String _inst2Id = "ca-app-pub-6245553460179561/4405282128";
  final String _inst3Id = "ca-app-pub-6245553460179561/7769812065";
  final String _inst4Id = "ca-app-pub-6245553460179561/7615621596";

  //StreamController streamController=new StreamController.broadcast();

  static AssetBundle _rootBundle;

  static BannerAd myBanner;

  static InterstitialAd myInterstitial1;
  static InterstitialAd myInterstitial2;
  static InterstitialAd myInterstitial3;
  static InterstitialAd myInterstitial4;

  static int counter = 0;

  BlocProvider({
    Key key,
    @required Widget child,
  }) : super(key: key, child: child) {
    _rootBundle = PlatformAssetBundle();

    _loadData();

    FirebaseAdMob.instance.initialize(appId: _appId);

    myInterstitial1 = InterstitialAd(
      adUnitId: _inst1Id,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if (event == MobileAdEvent.closed) myInterstitial1.dispose();
      },
    );

    myInterstitial2 = InterstitialAd(
      adUnitId: _inst2Id,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if (event == MobileAdEvent.closed) myInterstitial2.dispose();
      },
    );

    myInterstitial3 = InterstitialAd(
      adUnitId: _inst3Id,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if (event == MobileAdEvent.closed) myInterstitial3.dispose();
      },
    );

    myInterstitial4 = InterstitialAd(
      adUnitId: _inst4Id,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if (event == MobileAdEvent.closed) myInterstitial4.dispose();
      },
    );

    myBanner = BannerAd(
      adUnitId: _bannerId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  @override
  updateShouldNotify(InheritedWidget oldWidget) => true;

  void _loadHorses() async {
    _rootBundle.loadString("resorces/horses.json").then(
      (data) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        for (String name in jsonData.keys) {
          List<String> list = List<String>.from(jsonData[name]);
          horses.putIfAbsent(name, () => list);
        }
      },
    );
  }

  void _loadWeapons(Function next) async {
    _rootBundle.loadString("resorces/wapons.json").then(
      (data) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        for (String name in jsonData.keys) {
          List<String> list = List<String>.from(jsonData[name]);
          weapons.putIfAbsent(name, () => list);
        }
        next();
      },
    );
  }

  void _loadCheatCodes() async {
    _rootBundle.loadString("resorces/cheat code.json").then(
      (data) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        for (String name in jsonData.keys) {
          List<dynamic> list = jsonData[name];
          List<CheatCode> cheatCodeList = List();
          for (Map<String, dynamic> details in list) {
            cheatCodeList.add(CheatCode.fromJson(details));
          }
          cheatCodes.putIfAbsent(name, () => cheatCodeList);
        }
        _loadWeapons(_loadHorses);
      },
    );
  }

  void _loadData() => _loadCheatCodes();

  static void pressed() {
    counter++;
    switch (counter) {
      case 1:
        myInterstitial1
          ..load()
          ..show();
        break;
      case 5:
        myInterstitial2
          ..load()
          ..show();
        break;
      case 10:
        myInterstitial3
          ..load()
          ..show();
        break;
      case 15:
        myInterstitial4
          ..load()
          ..show();
        break;
    }
  }
}
