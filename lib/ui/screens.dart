import 'package:flutter/material.dart';

import 'home_view/home_view.dart';
import 'search_view/serach_view.dart';

class Screens extends StatefulWidget {
  Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final List<Widget> _children = [
    HomeView(),
    SearchView(),
  ];

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), label: "Home"),
          ],
        ),
      ),
    );
  }
}
