import 'package:flutter/material.dart';
import 'package:flutter_project_1/pages/contacts_page.dart';
import 'package:flutter_project_1/pages/gallery_page.dart';
import 'package:flutter_project_1/pages/news_page.dart';
import 'package:flutter_project_1/pages/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  int _selectedIndex = 0;

  List<Widget> pages = [
    News_page(),
    Gallery_page(),
    Todo_page(),
    Contacts_page()
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project 1",
      theme: ThemeData(brightness: Brightness.dark, fontFamily: "RaleWay"),
      home: Scaffold(
        body: IndexedStack(
          children: pages,
          index: _selectedIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          unselectedItemColor: Colors.white38,
          backgroundColor: colorMain,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(Icons.home),
                ),
                label: "News",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(Icons.photo_album_rounded),
              ),
              label: "Gallery",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(Icons.article),
              ),
              label: "Check",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(Icons.person_pin_rounded),
              ),
              label: "Contacts",
            )
          ],
        ),
      ),
      routes: {
    '/contactUserPage' : (context) => ContactUserPage(),
    '/selectedNewsPage' : (context) => SelectedNewsPage(),
        '/moreCommentsPage' : (context) => MoreCommentsPage(),
        '/albumPage' : (context) => Album_page(),
        '/photoPage' : (context) => PhotoPage()
      },
    );
  }
}
