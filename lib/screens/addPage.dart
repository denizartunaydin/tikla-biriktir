import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddPAgeState();
}

class AddPAgeState extends State {
  final txtBaslik = TextEditingController();
  final txtWebsite = TextEditingController();
  final txtPuan = TextEditingController();

  String satir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ekle"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: txtBaslik,
              decoration: InputDecoration(labelText: "Başlık"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: txtWebsite,
              decoration: InputDecoration(labelText: "Site URL"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: txtPuan,
              decoration: InputDecoration(labelText: "Puan"),
            ),
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              veriekle();
            },
            textColor: Colors.white,
            child: Text("Web Sitesi Kaydet"),
          )
        ],
      ),
    );
  }

  veriekle() {
    //Veritabanı yolu
    DocumentReference veriYolu =
        Firestore.instance.collection("website").document(txtBaslik.text);

    //Çoklu Veri Gönderme
    Map<String, dynamic> urunler = {
      "Baslik": txtBaslik.text,
      "Puan": txtPuan.text,
      "Site": txtWebsite.text
    };

    veriYolu.setData(urunler).whenComplete(() {});

    Navigator.pop(context);
  }
}
