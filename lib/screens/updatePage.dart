import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class UpdatePage extends StatefulWidget {
  String baslik, site, puan;
  UpdatePage(this.baslik, this.site, this.puan);
  @override
  State<StatefulWidget> createState() => UpdatePageState(baslik, site, puan);
}

class UpdatePageState extends State {
  String baslik, site, puan;

  final txtBaslik = TextEditingController();
  final txtWebsite = TextEditingController();
  final txtPuan = TextEditingController();

  UpdatePageState(this.baslik, this.site, this.puan);

  @override
  void initState() {
    txtBaslik.text = baslik;
    txtWebsite.text = site;
    txtPuan.text = puan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baslik),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: txtBaslik,
              decoration: InputDecoration(labelText: "Başlık"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: txtWebsite,
              decoration: InputDecoration(labelText: "Site URL"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: txtPuan,
              decoration: InputDecoration(labelText: "Puan"),
            ),
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              veriguncelle();
            },
            textColor: Colors.white,
            child: Text("Web Sitesi Güncelle"),
          )
        ],
      ),
    );
  }

  veriguncelle() {
    //Veritabanı yolu
    DocumentReference veriYolu =
        Firestore.instance.collection("website").document(baslik);

    Map<String, dynamic> urunGuncelveri = {
      "Baslik": txtBaslik.text,
      "Puan": txtPuan.text,
      "Site": txtWebsite.text
    };

    veriYolu.updateData(urunGuncelveri).whenComplete(() {});

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
  }
}
