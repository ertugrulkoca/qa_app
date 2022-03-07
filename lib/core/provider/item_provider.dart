import 'package:flutter/material.dart';

import '../model/questions/items.dart';

class ItemModelProvider extends ChangeNotifier {
  Items? question;
  Items? getQuestion() {
    return question;
  }

  void changeQuestion(Items q) {
    question = q;
    notifyListeners();
  }
}
