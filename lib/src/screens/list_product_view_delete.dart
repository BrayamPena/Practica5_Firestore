import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica5_firebase/src/providers/firebase_providers.dart';
import 'package:practica5_firebase/src/views/cardProduct.dart';

class LessProductView extends StatefulWidget {
  LessProductView({Key key}) : super(key: key);

  @override
  _LessProductViewState createState() => _LessProductViewState();
}

class _LessProductViewState extends State<LessProductView> {
  FirebaseProvider firestore;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Product List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.getAllProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new CardProduct(
                  productDocument: document, delornotdel: true);
            }).toList());
          }),
    );
  }
}
