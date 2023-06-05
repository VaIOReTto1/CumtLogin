import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> searchResults = [];

  List<String> _searchSchools(String query) {
    // TODO: 实现搜索逻辑
    return ['搜索结果1', '搜索结果2', '搜索结果3'];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: const Color.fromRGBO(56, 111, 211, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 345,
              child: Column(
                children: [
                  Expanded(flex: 190, child: Container()),
                  Expanded(
                      flex: 80,
                      child: Row(children: [
                        Expanded(flex: 40, child: Container()),
                        const Expanded(
                            flex: 200,
                            child: Text(
                              'Welcome\nBack',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(flex: 180, child: Container()),
                      ])),
                  Expanded(flex: 25, child: Container()),
                  Expanded(
                      flex: 20,
                      child: Row(children: [
                        Expanded(flex: 36, child: Container()),
                        const Expanded(
                            flex: 41,
                            child: Text('学校',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        Expanded(flex: 283, child: Container()),
                      ])),
                  Expanded(flex: 25, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 40,
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7.0),
                          hintText: "请输入学校",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                        onSubmitted: (query) {
                          setState(() {
                            searchResults = _searchSchools(query);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),
            ),
            Expanded(
              flex: 395,
              child: Container(
                height: 200,
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchResults[index]),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
