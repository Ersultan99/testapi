import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Forma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<PhotoData>> futurePhoto;

  @override
  void initState() {
    super.initState();
    futurePhoto = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<PhotoData>>(
        future: futurePhoto,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("nope");
            return Center(child: CircularProgressIndicator());
          } else {
            print(snapshot.data);
            return Container(child: _albumGridView(snapshot.data));
          }
        },
      )),
    );
  }
}

GridView _albumGridView(List<PhotoData> data) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: data.length,
    padding: EdgeInsets.all(2.0),
    itemBuilder: (BuildContext context, int index) {
      return _tile(data[index].id.toString(), data[index].title,
          data[index].thumbnailUrl);
    },
  );
}

GridTile _tile(String id, String title, String photoUrl) => GridTile(
    child: InkWell(
        onTap: () => print("click"),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.network(photoUrl, fit: BoxFit.contain),
                      ),
                      Container(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            )),
                      ),
                    ])))));

class PhotoData {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoData({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory PhotoData.fromJson(Map<String, dynamic> parsedJson) {
    return new PhotoData(
        albumId: parsedJson['albumId'],
        id: parsedJson['id'],
        title: parsedJson['title'],
        url: parsedJson['url'],
        thumbnailUrl: parsedJson['thumbnailUrl']);
  }

  static List<PhotoData> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PhotoData>((json) => PhotoData.fromJson(json)).toList();
  }
}
