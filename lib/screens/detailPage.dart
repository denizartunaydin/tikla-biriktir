import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_first/screens/updatePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  String baslik, site, puan;
  DetailPage(this.baslik, this.site, this.puan);
  @override
  State<StatefulWidget> createState() => DetailPageState(baslik, site, puan);
}

enum Choice { Delete, Update }

class DetailPageState extends State {
  final Completer<WebViewController> _controller =
      new Completer<WebViewController>();
  String baslik, site, puan;
  DetailPageState(this.baslik, this.site, this.puan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baslik),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              PopupMenuItem<Choice>(
                value: Choice.Delete,
                child: Text("Siteyi Kaldır"),
              ),
              PopupMenuItem<Choice>(
                value: Choice.Update,
                child: Text("Siteyi Güncelle"),
              )
            ],
          )
        ],
      ),
      body: WebView(
        initialUrl: site.toString(),
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

  void select(Choice choice) async {
    switch (choice) {
      case Choice.Delete:
        veriSil();
        Navigator.pop(context);
        break;
      case Choice.Update:
        gotoUpdatePage();
        break;
      default:
    }
  }

  void gotoUpdatePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdatePage(baslik, site, puan),
        ));
  }

  void veriSil() {
    DocumentReference veriYolu =
        Firestore.instance.collection("website").document(baslik);

    veriYolu.delete().whenComplete(() {
      print(baslik + "Silindi");
    });
  }
}
