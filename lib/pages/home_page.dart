import 'package:cursor_and_navbar_task4/pages/gallery_screen.dart';
import 'package:cursor_and_navbar_task4/pages/home_screen.dart';
import 'package:cursor_and_navbar_task4/pages/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeScreen(),
    const GalleryScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffeeeeee),
        items: const [
          Icon(Icons.home),
          Icon(Icons.photo_library),
          Icon(Icons.person)
        ],
        onTap: (index) {
          _page = index;
          _pageController.jumpToPage(index);
          setState(() {});
        },
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
