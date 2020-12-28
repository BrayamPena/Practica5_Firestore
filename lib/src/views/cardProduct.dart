import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:practica5_firebase/src/providers/firebase_providers.dart';

class CardProduct extends StatelessWidget {
  const CardProduct(
      {Key key, @required this.productDocument, @required this.delornotdel})
      : super(key: key);
  final DocumentSnapshot productDocument;
  final bool delornotdel;
  Widget build(BuildContext context) {
    @override
    final _card = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            placeholder: AssetImage('assets/activity_indicator.gif'),
            image: productDocument['image'] == ""
                ? NetworkImage(
                    "https://herlom.com/wp-content/uploads/2018/07/48129f.png")
                : NetworkImage(productDocument['image']),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 100),
            height: 230.0,
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Container(
            height: 55.0,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      productDocument['description'],
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      productDocument['model'],
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                if (delornotdel == true)
                  Column(
                    children: [
                      MaterialButton(
                        child: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          deleteProduct();
                        },
                      ),
                    ],
                  )
              ],
            ),
          ),
        )
      ],
    );
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0.0, 5.0),
            blurRadius: 1.0)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _card,
      ),
    );
  }

  void deleteProduct() async {
    FirebaseProvider firestore = FirebaseProvider();
    var desertRef = FirebaseStorage.instance
        .ref()
        .child("Products Images/${productDocument['model']}");
    desertRef.delete();

    await firestore.removeProduct(productDocument.id);
  }
}
