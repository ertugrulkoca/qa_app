import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
                questionListView(),
              ],
            ),
          ),
        ),
      ),
    );
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
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return profileContainer();
        },
      ),
    );
  }

  Padding profileContainer() {
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
        child: profileContainerInfo(),
      ),
    );
  }

  Stack profileContainerInfo() {
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
                  profileCardUserName(),
                  sizedBox(5),
                  profileCardUserInfo(),
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
          child: circleAvatar(),
        ),
      ],
    );
  }

  Text profileCardUserName() {
    return const Text(
      "Ertuğrul",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Text profileCardUserInfo() {
    return const Text("Lorem ipsum dolar sit ametLorem ipsum dolar sit amet",
        style: TextStyle(fontSize: 11, color: Colors.grey),
        textAlign: TextAlign.center);
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
          itemCount: 1,
          itemBuilder: (context, index) {
            return questionContainer();
          },
        ),
      ),
    );
  }

  SizedBox sizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Padding questionContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleAvatar(),
                questionUserInfo(),
                const Expanded(
                  child: SizedBox(),
                ),
                iconBookmark(),
              ],
            ),
            question(),
            questionIMG(),
          ],
        ),
      ),
    );
  }

  SizedBox circleAvatar() {
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

  Padding questionUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
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
            "Sabtu, 23 April 2021",
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

  Padding question() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "Permisi, saya mau tanya. Apakah dengan menggunakan 3 alat dibawah ini skincare akan meresab optimal? Terimakasih Jawabannya kakak",
        style: TextStyle(fontSize: 18, height: 1.5),
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
