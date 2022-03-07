import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/core/provider/item_provider.dart';
import 'core/provider/page_index_provider.dart';
import 'ui/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemModelProvider()),
        ChangeNotifierProvider(create: (context) => IndexModelProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stackoverflow App',
        home: Screens(),
      ),
    );
  }
}
