import 'package:flutter/material.dart';
import 'package:qa_application/ui/screens.dart';
import 'package:qa_application/ui/search_view/serach_view.dart';

import 'ui/home_view/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeView(),
      // home: SearchView(39628),
    );
  }
}
