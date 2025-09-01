import 'dart:async';

import 'package:finance_diary/data/diaryListData.dart';
import 'package:finance_diary/system/diarySystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:finance_diary/screen/diaryPage.dart';
import 'package:finance_diary/screen/settingPage.dart';
import 'package:finance_diary/screen/analizePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:finance_diary/Ads.dart';


void main() {


  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  loadRewardFullBanner();

  runApp(
      MaterialApp(home: MainPage(), debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
      ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;
  List col = [Colors.green[300], Colors.black, Colors.black];

  late BannerAd _banner;
  var bannerHeight = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }





  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    _banner = BannerAd(
        adUnitId: bannerAdId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            print('Ad loaded.');

            if (bannerHeight == 0.0) {
              setState(() {
                bannerHeight = _banner.size.height.toDouble();
              });
            }
          },
            // Called when an ad request failed.
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            ad.dispose();
            print('Ad failed to load: $error');
            },
            // Called when an ad opens an overlay that covers the screen.
            onAdOpened: (Ad ad) => print('Ad opened.'),
            // Called when an ad removes an overlay that covers the screen.
            onAdClosed: (Ad ad) => print('Ad closed.'),
            // Called when an impression occurs on the ad.
            onAdImpression: (Ad ad) => print('Ad impression.'),
            )
            )..load();


            return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(bannerHeight),
              child: AppBar(
                backgroundColor: Colors.green[300],
                title: Container(
                  alignment: Alignment.center,
                  child: AdWidget(ad: _banner,),
                  height: _banner.size.height.toDouble(),
                ),
                shadowColor: Colors.transparent,
              ),
            ),

            body: WillPopScope(
              onWillPop: onWillPop,
              child: TabBarView(
              children: [DiaryPage(), AnalizePage(), SettingPage()],
              controller: tabController),
            ),


        bottomNavigationBar: TabBar(
          indicatorColor: Colors.green[200],
          labelColor: Colors.green,
          labelStyle: TextStyle(),
          tabs: <Tab>[
            Tab(
              icon: SvgPicture.asset(
                "svg/file_ux_icon.svg",
                height: 27.sp,
                color: col[0],
              ),
            ),
            Tab(
              icon: Icon(Icons.timeline, size: 28.sp, color: col[1],)
            ),
            Tab(
                icon: Icon(Icons.add_circle_outline, size: 31.sp, color: col[2],)
            )
          ],

          controller: tabController,
          onTap: (value) {
            setState(() {
              switch (value) {
                case 0:
                  col = [Colors.green[300], Colors.black, Colors.black];
                  break;
                case 1:
                  col = [Colors.black, Colors.green[300], Colors.black];
                  break;
                case 2:
                  col = [Colors.black, Colors.black, Colors.green[300]];
                  break;
              }
            });
          },
        ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
    _banner.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  var c = 0;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //https://api.flutter.dev/flutter/dart-ui/AppLifecycleState-class.html
    switch (state) {
      case AppLifecycleState.resumed:
      // 앱이 표시되고 사용자 입력에 응답합니다.
      // 주의! 최초 앱 실행때는 해당 이벤트가 발생하지 않습니다.
        print("resumed");
        print(c);
        if (c == 2) {
          try {
            appOpenAd!.show();
            c = 0;
          } catch(e) {
            loadAppOpenAd();
            print(e);
          }
        }
        break;
      case AppLifecycleState.inactive:
      // 앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다.
      // ios에서는 포 그라운드 비활성 상태에서 실행되는 앱 또는 Flutter 호스트 뷰에 해당합니다.
      // 안드로이드에서는 화면 분할 앱, 전화 통화, PIP 앱, 시스템 대화 상자 또는 다른 창과 같은 다른 활동이 집중되면 앱이이 상태로 전환됩니다.
      // inactive가 발생되고 얼마후 pasued가 발생합니다.
        print("inactive");
        break;
      case AppLifecycleState.paused:
      // 앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다.
      // 안드로이드의 onPause()와 동일합니다.
      // 응용 프로그램이 이 상태에 있으면 엔진은 Window.onBeginFrame 및 Window.onDrawFrame 콜백을 호출하지 않습니다.
        print("paused");
        loadAppOpenAd();
        if (c < 2) c += 1;
        break;
      case AppLifecycleState.detached:
      // 응용 프로그램은 여전히 flutter 엔진에서 호스팅되지만 "호스트 View"에서 분리됩니다.
      // 앱이 이 상태에 있으면 엔진이 "View"없이 실행됩니다.
      // 엔진이 처음 초기화 될 때 "View" 연결 진행 중이거나 네비게이터 팝으로 인해 "View"가 파괴 된 후 일 수 있습니다.
        print("detached");
        break;
    }
  }


  DateTime? currentBackPressTime;
  Future<bool> onWillPop(){

    DateTime now = DateTime.now();

    if(currentBackPressTime == null || now.difference(currentBackPressTime!)
        > Duration(seconds: 2))
    {

      currentBackPressTime = now;
      final msg = "'뒤로'버튼을 한 번 더 누르시면 종료됩니다.";

      Fluttertoast.showToast(msg: msg);
      return Future.value(false);

    }

    return Future.value(true);

  }


}


