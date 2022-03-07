import 'package:flutter/material.dart';

class IndexModelProvider extends ChangeNotifier {
  int index = 0;
  int getIndex() {
    return index;
  }

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
