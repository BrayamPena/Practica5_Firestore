import 'package:flutter/material.dart';
import 'package:practica5_firebase/src/screens/list_products_screen.dart';
import 'package:practica5_firebase/src/screens/newProduct.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            MaterialButton(
              child: Icon(Icons.add_circle),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NewProduct()));
              },
            )
          ],
        ),*/
        body: ListProducts(),
      ),
    );
  }
}
