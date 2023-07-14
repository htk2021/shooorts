import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screens/ShortsPage.dart';
import 'package:fluttertest/screens/MyPage.dart';
import 'package:fluttertest/screens/TrainingPage.dart';
import 'package:fluttertest/models/AppColors.dart';
import 'package:fluttertest/widgets/shortsPlayer.dart';
// import 'package:shared_preferences/shared_preferences.dart';



class TabPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          TrainingPage(),
          ShortsList(),
          MyPage(),
        ],
      ),
      bottomNavigationBar:
          Container(
            color: AppColors.tabBarColor,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    icon: Icon(CupertinoIcons.chat_bubble), text: "훈련소"
                ),
                Tab(icon: Icon(CupertinoIcons.arrowtriangle_right), text: "쇼-오츠"),
                Tab(icon: Icon(CupertinoIcons.person), text: "내 정보"),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
            ),
          )
    );
  }
}
