import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qa_application/core/service/service.dart';
import 'package:qa_application/ui/search_view/serach_view.dart';
import '../../core/model/questions/items.dart';
import '../components/bottom_bar.dart';
import '../components/dummy_pages.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Service service;
  int _count = 5;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    service = Service();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _getMoreData() {
    print("get more data2");
    _count += 5;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: questionsFutureBuilder,
      bottomNavigationBar: buttomBar(context, 0),
    );
  }

  Widget get questionsFutureBuilder => FutureBuilder<List<Items>>(
        future: service.getQuestion(_count),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                var list = snapshot.data;

                List<Items> questionList = [];

                for (var item in list!) {
                  questionList.add(item);
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: questionList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == questionList.length) {
                      return CupertinoActivityIndicator();
                    }
                    String tagList =
                        convertTags(questionList[index].tags!).join(",");
                    String questionTitle = questionList[index].title ?? "";
                    String questionBody =
                        _parseHtmlString(questionList[index].body ?? "");
                    String displayName = "";
                    String profileImage = "";
                    int answerCount = questionList[index].answerCount ?? 0;
                    int creationDate = questionList[index].creationDate ?? 0;
                    // print(questionList[index].answers![index]);

                    if (questionList[index].owner != null) {
                      displayName =
                          questionList[index].owner!.displayName ?? "";
                      profileImage = questionList[index].owner!.profileImage ??
                          "https://dummyimage.com/600x400/000/fff";
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchView(questionList[index])));
                      },
                      child: questionContainer(displayName, questionTitle,
                          answerCount, tagList, profileImage, creationDate),
                    );
                  },
                );
              } else
                return notFoundWidget;
            default:
              return waitingWidget;
          }
        },
      );
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

  Widget get _notFoundWidget => const Center(child: Text("not found"));
  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());
  // Widget get getQuestionsFuture => FutureBuilder<List<Items>>{
  //   future: service.getQuestion(),
  //       builder: (context, snapShot) {
  //         if (snapShot.hasData) {
  //           var list = snapShot.data;
  //           return ListView.builder(
  //             itemCount: 5,
  //             itemBuilder: (context, index) {
  //               return questionContainer();
  //             },
  //           );
  //         }
  //       },
  // };

  AppBar appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: userInfoAppbar(),
      ),
      actions: [
        circleAvatar("assets/pp.jpg"),
      ],
    );
  }

  Column userInfoAppbar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ertuğrul",
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const Text(
          "Mobil Developer",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  SizedBox circleAvatar(String img) {
    return SizedBox(
      height: 65,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(
          img,
        ),
      ),
    );
  }

  SizedBox circleNetWorkAvatar(String img) {
    return SizedBox(
      height: 65,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(img),
      ),
    );
  }

  Padding questionContainer(String name, String title, int answer, String tags,
      String imgUrl, int date) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              circleNetWorkAvatar(imgUrl),
              userInfoContainer(name, date),
              const Expanded(
                child: SizedBox(),
              ),
              iconBookmark(),
            ],
          ),
          question(title),
          questionInfo(answer, tags),
          underLine()
        ],
      ),
    );
  }

  Padding userInfoContainer(String name, int date) {
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
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
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

  Padding question(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, height: 1.5),
      ),
    );
  }

  Padding questionInfo(int answer, String tags) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$answer answer"),
          SizedBox(width: 30),
          Flexible(child: Text(tags, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Container underLine() {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
