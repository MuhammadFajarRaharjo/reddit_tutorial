import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/home/delegates/search_community_delegate.dart';
import 'package:reddit_tutorial/features/home/drawers/profile_drawer.dart';
import 'package:reddit_tutorial/models/user_model.dart';
import 'package:reddit_tutorial/themes/pallete.dart';

import '../drawers/community_list_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void showDrawer(BuildContext context) => Scaffold.of(context).openDrawer();
  void showEndDrawer(BuildContext context) =>
      Scaffold.of(context).openEndDrawer();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: _header(context, user),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawe(),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: ref.watch(themeNotifierProvider).iconTheme.color,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.add)),
        ],
        onTap: (value) => setState(() {
          _page = value;
        }),
        currentIndex: _page,
      ),
      body: Constants.tabsWidget[_page],
    );
  }

  AppBar _header(BuildContext context, UserModel? user) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => showDrawer(context),
          icon: const Icon(Icons.menu),
        ),
      ),
      elevation: 0,
      title: const Text("Home"),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () => showSearch(
                context: context, delegate: SearchCommunityDelegate(ref)),
            icon: const Icon(Icons.search)),
        Builder(builder: (context) {
          return IconButton(
            onPressed: () => showEndDrawer(context),
            icon: ClipOval(
              child: Image.network(user!.profileUrl, fit: BoxFit.cover),
            ),
          );
        }),
      ],
    );
  }
}
