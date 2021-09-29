import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Preview extends StatefulWidget {
  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  final url = "https://jsonplaceholder.typicode.com/users/1/posts";

  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    fetchPosts();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
            itemCount: _postsJson.length,
            itemBuilder: (context, i) {
              final post = _postsJson[i];
              return Card(
                  child: Text(
                      "Title:${post["title"]}\n Body: ${post["body"]}\n\n"));
            }),
      ),
    );
  }
}
