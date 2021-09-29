import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  Future getUserData() async {
    var response = await http.get(Uri.https(
      'jsonplaceholder.typicode.com',
      'users/1',
    ));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(
        u["name"],
        u["email"],
        u["username"],
        u["phone"],
        u[",website"],
        u["bs"],
        u["catchPrase"],
        u["adress"],
      );
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Card(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  );
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ListView(
                          children: [
                            Text(snapshot.data[i].name),
                            Text(snapshot.data[i].email),
                            Text(snapshot.data[i].phone),
                            Text(snapshot.data[i].website),
                            Text(snapshot.data[i].bs),
                            Text(snapshot.data[i].catchPrase),
                            Text(snapshot.data[i].adress)
                          ],
                        );
                      });
              }),
        ),
      ),
    );
  }
}

class User {
  final String name, email, userName, phone, website, bs, catchPrase, adress;
  User(this.name, this.email, this.userName, this.phone, this.website, this.bs,
      this.catchPrase, this.adress);
}
