import 'package:firebase_first/screens/addPage.dart';
import 'package:firebase_first/screens/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tıkla Biriktir'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Choice { Add }

class _MyHomePageState extends State<MyHomePage> {
  String baslik, site, puan;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<Choice>(
              onSelected: select,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
                PopupMenuItem<Choice>(
                  value: Choice.Add,
                  child: Text("Yeni Ekle"),
                )
              ],
            )
          ],
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance.collection("website").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return Card(
                          color: Colors.blue,
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(9.0),
                                      child: Text(documentSnapshot["Baslik"]
                                          .substring(0, 1)),
                                    )
                                  ],
                                )),
                            title: Text(
                              documentSnapshot["Baslik"].toString(),
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Text(
                                  "Görev Puanı: " +
                                      documentSnapshot["Puan"].toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              baslik = documentSnapshot["Baslik"].toString();
                              site = documentSnapshot["Site"].toString();
                              puan = documentSnapshot["Puan"].toString();
                              gotoDetail();
                            },
                          ),
                        );
                      });
                }
              },
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void select(Choice choice) async {
    int result;
    switch (choice) {
      case Choice.Add:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ));
        break;
      default:
    }
  }

  void gotoDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(baslik, site, puan),
        ));
  }

  verioku(String deneme) {
    DocumentReference veriYolu =
        Firestore.instance.collection("website").document(deneme);

    //Veri Okuma

    veriYolu.get().then((alinanveri) {
      print(alinanveri.data["Id"]);
      print(alinanveri.data["Urun"]);
    });
  }
}
