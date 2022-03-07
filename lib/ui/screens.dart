import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/core/provider/page_index_provider.dart';

import 'components/dummy_pages.dart';
import 'home_view/home_view.dart';
import 'search_view/serach_view.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final List<Widget> _children = [
    HomeView(),
    SearchView(),
    notFoundWidget,
    notFoundWidget,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexModelProvider>(
        builder: (context, value, child) {
          return Center(
            child: _children[value.getIndex()],
          );
        },
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
        child: Consumer<IndexModelProvider>(
          builder: (context, value, child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.blue,
              currentIndex: value.getIndex(),
              onTap: (i) {
                value.changeIndex(i);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: "Ask"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_border), label: "Bookmark"),
              ],
            );
          },
        ),
      ),
    );
  }
}
