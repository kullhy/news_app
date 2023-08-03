import 'package:flutter/material.dart';
import 'package:learn_bloc_2/pages/book_mark/book_mark_pages.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../utils/utils.dart';
import '../home/home_page.dart';

import '../search/search_page.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  var currentIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const BookMarkPage(),
    const SamplePage(
      title: 'Profile Page',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// book mark
          SalomonBottomBarItem(
            icon: const Icon(Icons.bookmark_add_outlined),
            title: const Text("Book mark"),
            selectedColor: Colors.pink,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.title,
          style: SafeGoogleFont(
            'Mulish',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.2575,
            letterSpacing: 1,
            color: const Color(0xff1e2022),
          ),
        ),
      ),
    );
  }
}
