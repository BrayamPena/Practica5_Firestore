//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica5_firebase/src/providers/firebase_providers.dart';
import 'package:practica5_firebase/src/screens/list_product_view_delete.dart';
import 'package:practica5_firebase/src/screens/newProduct.dart';
import 'package:practica5_firebase/src/views/cardProduct.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  FirebaseProvider firestore;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return /*CustomScrollView(slivers: [
      StreamBuilder(
          stream: firestore.getAllProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return CardProduct(productDocument: snapshot.data.docs[index]);
              }, childCount: snapshot.data.docs.length),
            );
          }
          ),
    ]);*/
        Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: <Widget>[
          MaterialButton(
            child: Icon(Icons.add_circle, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewProduct()));
            },
          ),
          MaterialButton(
            child: Icon(Icons.remove_circle, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LessProductView()));
            },
          ),
        ],
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
                  productDocument: document, delornotdel: false);
              /*ListTile(
                    title: new Text(document.data()['model']),
                    subtitle: new Text(document.data()['description']),
                  );*/
            }).toList());
          }),
    );
  }
}
