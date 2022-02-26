import 'package:flutter/material.dart';

import '../search_view/serach_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanya Jawab",
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Hai, kamu bisa bertanya apa saja",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        actions: const [
          SizedBox(
            height: 65,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                "assets/pp.jpg",
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 65,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/pp.jpg",
                        ),
                      ),
                    ),
                    Padding(
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
                          Text(
                            "Sabtu, 23 April 2021",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const Icon(
                      Icons.bookmark_border,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Apakah mekan mie dengan minuman bersoda berbahya bagi kesehatan?? Mhon di jawab bagi yang tahu. Terimakasih..",
                    style: TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("23 Jawaban"),
                      Row(
                        children: const [Text("#kesehatan #makanan")],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  height: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
 Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Putin Abu",
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
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const Icon(
                      Icons.bookmark_border,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      "Apakah mekan mie dengan minuman bersoda berbahya bagi kesehatan?? Mhon di jawab bagi yang tahu. Terimakasih.."),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("23 Jawaban"),
                      Row(
                        children: const [Text("#kesehatan #makanan")],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  height: 1,
                )
              ],
            ),
          ),
*/
