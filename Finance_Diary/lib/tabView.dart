import 'package:finance_diary/screen/analizePage.dart';
import 'package:finance_diary/screen/diaryPage.dart';
import 'package:finance_diary/screen/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'data/diaryListData.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView>   with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
            children: [DiaryPage(), AnalizePage(), SettingPage()],
            controller: tabController),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.green[200],
          labelColor: Colors.black,
          labelStyle: TextStyle(),
          tabs: <Tab>[
            Tab(
              icon: SvgPicture.asset(
                "svg/file_ux_icon.svg",
                height: 30,
              ),
            ),
            Tab(
                icon: Icon(Icons.timeline, size: 30, color: Colors.black,)
            ),
            Tab(
                icon: Icon(Icons.add_circle_outline, size: 35, color: Colors.black,)
            )
          ],
          controller: tabController,
        ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}