import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qa_application/core/model/questions/answers.dart';
import 'package:qa_application/core/model/users/users.dart';

import '../../core/model/questions/items.dart';
import '../../core/model/users/user_items.dart';
import '../../core/service/service.dart';
import '../components/bottom_bar.dart';
import '../components/dummy_pages.dart';

class SearchView extends StatefulWidget {
  Items question;
  SearchView(
    this.question,
  ) : super();

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Service service;
  @override
  void initState() {
    super.initState();
    service = Service();

    // List<Answers> answerList = [];
    // if (widget.question.answers != null) {
    //   for (var item in widget.question.answers!) {
    //     answerList.add(item);
    //     print(item.owner!.displayName);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(),
                  sizedBox(30),
                  const Text("Profile"),
                  sizedBox(20),
                  profileContainerListView(),
                  sizedBox(30),
                  const Text("Post"),
                  sizedBox(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: questionContainer(
                        widget.question.owner!.displayName!,
                        widget.question.creationDate!,
                        widget.question.title!,
                        _parseHtmlString(widget.question.body!),
                        widget.question.owner!.profileImage!),
                  ),
                  questionListView(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: buttomBar(context, 1));
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Pengguna, topik, tema",
              hintStyle: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox profileContainerListView() {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<UserItems>>(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                var list = snapshot.data;
                List<UserItems> userList = [];
                for (var item in list!) {
                  userList.add(item);
                  print(item.displayName);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return profileContainer(
                        userList[index].displayName!,
                        _parseHtmlString(userList[index].aboutMe!),
                        userList[index].profileImage);
                  },
                );
              } else {
                return notFoundWidget;
              }
            default:
              return waitingWidget;
          }
        },
      ),
    );
  }

  Padding profileContainer(String name, bio, imgUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 20,
                offset: const Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: profileContainerInfo(name, bio, imgUrl),
      ),
    );
  }

  Stack profileContainerInfo(String name, bio, imgUrl) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  profileCardUserName(name),
                  sizedBox(5),
                  profileCardUserInfo(bio),
                  sizedBox(5),
                  followButton(),
                  sizedBox(15),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: circleNetWorkAvatar(imgUrl),
        ),
      ],
    );
  }

  Text profileCardUserName(String name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Flexible profileCardUserInfo(String bio) {
    return Flexible(
      child: Text(bio,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
          textAlign: TextAlign.center),
    );
  }

  GestureDetector followButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Text(
            "Follow",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding questionListView() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.question.answers!.length,
          itemBuilder: (context, index) {
            List<Answers> answerList = [];
            if (widget.question.answers != null) {
              for (var item in widget.question.answers!) {
                answerList.add(item);
                // print(item.owner!.displayName);
              }
            }

            // String tagList = convertTags(widget.question.tags!).join(",");
            String answerBody = _parseHtmlString(answerList[index].body ?? "");
            String displayName = "";
            String profileImage = "";
            // int answerCount = widget.question.answerCount ?? 0;
            int creationDate = answerList[index].creationDate ?? 0;

            if (widget.question.owner != null) {
              displayName = answerList[index].owner!.displayName ?? "";
              profileImage = answerList[index].owner!.profileImage ??
                  "https://dummyimage.com/600x400/000/fff";
            }
            return questionContainer(
                displayName, creationDate, "", answerBody, profileImage);
          },
        ),
      ),
    );
  }
  // Padding questionListView() {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 30),
  //     child: SizedBox(
  //       width: double.infinity,
  //       child: FutureBuilder<List<Items>>(
  //         future: service.getQuestionById(39628),
  //         builder: (context, snapshot) {
  //           switch (snapshot.connectionState) {
  //             case ConnectionState.done:
  //               if (snapshot.hasData) {
  //                 var list = snapshot.data;
  //                 List<Items> questionList = [];
  //                 for (var item in list!) {
  //                   questionList.add(item);
  //                 }
  //                 return ListView.builder(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   scrollDirection: Axis.vertical,
  //                   itemCount: 1,
  //                   itemBuilder: (context, index) {
  //                     String tagList =
  //                         convertTags(questionList[index].tags!).join(",");
  //                     String questionTitle = questionList[index].title ?? "";
  //                     String questionBody =
  //                         _parseHtmlString(questionList[index].body ?? "");
  //                     String displayName = "";
  //                     String profileImage = "";
  //                     int answerCount = questionList[index].answerCount ?? 0;
  //                     int creationDate = questionList[index].creationDate ?? 0;

  //                     if (questionList[index].owner != null) {
  //                       displayName =
  //                           questionList[index].owner!.displayName ?? "";
  //                       profileImage =
  //                           questionList[index].owner!.profileImage ??
  //                               "https://dummyimage.com/600x400/000/fff";
  //                     }
  //                     return questionContainer(displayName, creationDate,
  //                         questionTitle, questionBody, profileImage);
  //                   },
  //                 );
  //               } else {
  //                 return notFoundWidget;
  //               }
  //             default:
  //               return waitingWidget;
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  List<String?> convertTags(List<String?> list) {
    List<String?> x = [];
    for (var i = 0; i < list.length; i++) {
      x.add("#" + list[i]!);
    }

    return x;
  }

  String _parseHtmlString(String htmlString) {
    String parsedHtml = Bidi.stripHtmlIfNeeded(htmlString);
    return parsedHtml;
  }

  SizedBox sizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Padding questionContainer(
      String name, int date, String title, String body, String imgUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleNetWorkAvatar(imgUrl),
                userInfo(name, date),
                const Expanded(
                  child: SizedBox(),
                ),
                iconBookmark(),
              ],
            ),
            question(title, body),
            // questionIMG(),
          ],
        ),
      ),
    );
  }

  // Padding answerListView() {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 30),
  //     child: SizedBox(
  //       width: double.infinity,
  //       child: FutureBuilder<List<Items>>(
  //         future: service.getAnswerById(39628),
  //         builder: (context, snapshot) {
  //           switch (snapshot.connectionState) {
  //             case ConnectionState.done:
  //               if (snapshot.hasData) {
  //                 var list = snapshot.data;
  //                 List<Items> answerList = [];
  //                 for (var item in list!) {
  //                   answerList.add(item);
  //                 }
  //                 return ListView.builder(
  //                   itemCount: answerList.length,
  //                   itemBuilder: (context, index) {
  //                     String answerTitle = answerList[index].title ?? "";
  //                     String answerBody =
  //                         _parseHtmlString(answerList[index].body ?? "");
  //                     String displayName = "";
  //                     String profileImage = "";
  //                     int creationDate = answerList[index].creationDate ?? 0;
  //                     if (answerList[index].owner != null) {
  //                       displayName =
  //                           answerList[index].owner!.displayName ?? "";
  //                       profileImage = answerList[index].owner!.profileImage ??
  //                           "https://dummyimage.com/600x400/000/fff";
  //                     }
  //                     return Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         circleNetWorkAvatar(profileImage),
  //                         userInfo(displayName, creationDate),
  //                         const Expanded(
  //                           child: SizedBox(),
  //                         ),
  //                         question(answerTitle, answerBody)
  //                       ],
  //                     );
  //                   },
  //                 );
  //               } else {
  //                 return notFoundWidget;
  //               }
  //             default:
  //               return waitingWidget;
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  SizedBox circleAvatar(String imgUrl) {
    return const SizedBox(
      height: 65,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(
          "assets/pp.jpg",
        ),
      ),
    );
  }

  SizedBox circleNetWorkAvatar(String imgUrl) {
    return SizedBox(
      height: 65,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imgUrl),
      ),
    );
  }

  Padding userInfo(String name, int date) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$date",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Icon iconBookmark() {
    return const Icon(
      Icons.bookmark_border,
      color: Colors.black,
      size: 20,
    );
  }

  Padding question(String title, body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
          ),
          sizedBox(10),
          Text(
            body,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Image questionIMG() {
    return Image.asset(
      "assets/skincare.png",
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
