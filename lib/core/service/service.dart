import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:qa_application/core/model/questions/items.dart';
import 'package:qa_application/core/model/questions/questions.dart';
import 'package:qa_application/core/model/users/user_items.dart';

import '../model/users/users.dart';

class Service {
  // static const String questionUrl =
  //     "https://api.stackexchange.com/2.3/questions?page=1&pagesize=1&order=asc&sort=activity&site=stackoverflow&filter=!IF84q-Z.*ltXwUWAk0TjGTVsx1NQ1CJkKtr)5aeDkjBAGw3";
  static const String questionUrl = "api.stackexchange.com";

  Future<List<Items>> getQuestion(int count) async {
    var url = Uri.https(questionUrl, "/2.3/questions", {
      "page": "1",
      "pagesize": "$count",
      "order": "asc",
      "sort": "activity",
      "site": "stackoverflow",
      "filter": "!IF84q-Z.*ltXwUWAk0TjGTVsx1NQ1CJkKtr)5aeDkjBAGw3"
    });
    final response = await http.get(url);
    switch (response.statusCode) {
      case HttpStatus.ok:
        // print(response.body);
        List<Items> items =
            Questions.fromJson(jsonDecode(response.body)).items ?? [];
        return items;

      default:
        List<Items> items = [];
        return items;
    }
  }

  Future<List<UserItems>> getUsers() async {
    var url = Uri.https(questionUrl, "/2.3/users", {
      "page": "1",
      "pagesize": "5",
      "order": "desc",
      "sort": "reputation",
      "site": "stackoverflow",
      "filter": "!gkOQYby(63OO_T-LWLuI(1)F64hV1AyNFAr"
    });
    final response = await http.get(url);
    switch (response.statusCode) {
      case HttpStatus.ok:
        // print(response.body);
        List<UserItems> items =
            Users.fromJson(jsonDecode(response.body)).items ?? [];
        return items;

      default:
        List<UserItems> items = [];
        return items;
    }
  }

  // Future<List<Items>> getQuestionById(int id) async {
  //   var url = Uri.https(questionUrl, "/2.3/questions/$id", {
  //     "order": "desc",
  //     "sort": "activity",
  //     "site": "stackoverflow",
  //     "filter": "!ak79D-df_WGWbj",
  //   });
  //   final response = await http.get(url);
  //   switch (response.statusCode) {
  //     case HttpStatus.ok:
  //       // print(response.body);
  //       List<Items> items =
  //           Questions.fromJson(jsonDecode(response.body)).items ?? [];
  //       return items;

  //     default:
  //       List<Items> items = [];
  //       return items;
  //   }
  // }

  // Future<List<Items>> getAnswerById(int id) async {
  //   var url = Uri.https(questionUrl, "/2.3/questions/$id/answers", {
  //     "order": "desc",
  //     "sort": "activity",
  //     "site": "stackoverflow",
  //     "filter": "!ak79D-df_WSOSy",
  //   });
  //   final response = await http.get(url);
  //   switch (response.statusCode) {
  //     case HttpStatus.ok:
  //       // print(response.body);
  //       List<Items> items =
  //           Questions.fromJson(jsonDecode(response.body)).items ?? [];
  //       return items;

  //     default:
  //       List<Items> items = [];
  //       return items;
  //   }
  // }
}
