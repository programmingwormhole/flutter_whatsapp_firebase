import 'package:flutter/material.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/views/SettingsScreen/setting_screen.dart';
import 'package:whatsapp_chat/views/TabView/CallsTab/call_tab.dart';
import 'package:whatsapp_chat/views/TabView/ChatTab/chat_tab.dart';
import 'package:whatsapp_chat/views/TabView/CommunityTab/community_tab.dart';

import '../../components/pop_up_menu_item.dart';
import '../../components/tabs.dart';
import '../../utils/config.dart';
import '../TabView/StatusTab/status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  List<PopupMenuEntry<dynamic>> popUpItems = [
    popupMenuItem(title: 'New group', onTap: () {}, value: 0),
    popupMenuItem(title: 'New broadcast', onTap: () {}, value: 1),
    popupMenuItem(title: 'Linked device', onTap: () {}, value: 2),
    popupMenuItem(title: 'Starred message', onTap: () {}, value: 3),
    popupMenuItem(title: 'Settings', onTap: () {}, value: 4),
  ];
  IconData floatingIcon = Icons.message;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    )..addListener(() {
        setState(() {
          switch (_tabController!.index) {
            case 0:
              popUpItems = [
                popupMenuItem(title: 'Settings', value: 0),
              ];
              break;
            case 1:
              popUpItems = [
                popupMenuItem(title: 'New group', value: 0),
                popupMenuItem(title: 'New broadcast', value: 1),
                popupMenuItem(title: 'Linked device', value: 2),
                popupMenuItem(title: 'Starred message', value: 3),
                popupMenuItem(title: 'Settings', value: 4),
              ];
              floatingIcon = Icons.message;
              break;
            case 2:
              popUpItems = [
                popupMenuItem(title: 'Status Privacy', value: 0),
                popupMenuItem(title: 'Settings', value: 1),
              ];
              floatingIcon = Icons.camera_alt;
              break;
            case 3:
              popUpItems = [
                popupMenuItem(title: 'Clear call logs', value: 0),
                popupMenuItem(title: 'Settings', value: 1),
              ];
              floatingIcon = Icons.add_ic_call;
              break;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        title: Text(appName,
          style: TextStyle(
            color: white.withOpacity(.5),
          ),
        ),
        actions: [
          Icon(
            Icons.camera_alt_outlined,
            color: white.withOpacity(.5),
            size: 26,
          ),
          const SizedBox(
            width: 18,
          ),
          Icon(
            Icons.search,
            color: white.withOpacity(.5),
            size: 26,
          ),
          PopupMenuButton(
            onSelected: (result) {
              switch (_tabController!.index) {
                case 0:
                  switch (result) {
                    case 0:
                      navigator(context, const SettingScreen());
                      break;
                  }
                  break;
                case 1:
                  switch (result) {
                    case 0:
                      print('New Group Tapped');
                      break;
                    case 1:
                      print('New broadcast tapped');
                      break;
                    case 2:
                      print('Linked Device tapped');
                      break;
                    case 3:
                      print('Starred message tapped');
                      break;
                    case 4:
                      navigator(context, const SettingScreen());
                  }
                  break;
                case 2:
                  switch (result) {
                    case 0:
                      print('New Group Tapped');
                      break;
                    case 1:
                      navigator(context, const SettingScreen());
                      break;
                  }
                case 3:
                  switch (result) {
                    case 0:
                      print('New Group Tapped');
                      break;
                    case 1:
                      navigator(context, const SettingScreen());
                      break;
                  }
              }
            },
            color: white,
            icon: Icon(
              Icons.more_vert,
              size: 26,
              color: white.withOpacity(0.5),
            ),
            itemBuilder: (BuildContext context) => popUpItems,
          ),
        ],
        bottom: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: white.withOpacity(.5),
          labelColor: white,
          isScrollable: false,
          indicatorColor: primary,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: Center(
        child: TabBarView(
          controller: _tabController,
          children: const [
            CommunityTab(),
            ChatTab(),
            StatusScreen(),
            CallTab(),
          ],
        ),
      ),
      floatingActionButton: _tabController!.index == 0
          ? null
          : _tabController!.index == 2
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 47,
                      width: 47,
                      child: FittedBox(
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          backgroundColor: white.withOpacity(.1),
                          onPressed: () {},
                          child: const Icon(
                            Icons.edit,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: primary,
                      onPressed: () {},
                      child: Icon(
                        floatingIcon,
                        color: white,
                      ),
                    ),
                  ],
                )
              : FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: primary,
                  onPressed: () {},
                  child: Icon(
                    floatingIcon,
                    color: white,
                  ),
                ),
    );
  }
}
