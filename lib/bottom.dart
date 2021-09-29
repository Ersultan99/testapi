import 'package:flutter/material.dart';
import 'Albom.dart';
import 'Forma.dart';
import 'Persons.dart';
import 'Posts.dart';
import 'Preview.dart';
import 'User.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Person(),
    Preview(),
    Albom(),
    Posts(),
    Forma(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedIconTheme: IconThemeData(
          color: const Color(0xFF200087),
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.black12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.people),
            ),
            title: Text(
              "Пользователи",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.person),
            ),
            title: Text(
              "Пользователь",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.publish),
            ),
            title: Text(
              "Посты",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.panorama),
            ),
            title: Text(
              "Альбом",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.photo_album),
            ),
            title: Text(
              "Посты",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.album),
            ),
            title: Text(
              "Альбом",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
    );
  }
}
