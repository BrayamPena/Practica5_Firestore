import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica5_firebase/src/models/ProdutDAO.dart';
import 'package:practica5_firebase/src/providers/firebase_providers.dart';
import 'package:practica5_firebase/src/screens/list_products_screen.dart';

class NewProduct extends StatefulWidget {
  NewProduct({Key key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  String imagePath;
  File image;
  final picker = ImagePicker();
  bool loading = false;
  FirebaseProvider firestore;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtModel = TextEditingController();
  @override
  void initState() {
    super.initState();
    firestore = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    final tffName = TextFormField(
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 20, color: Colors.white),
      controller: txtName,
      enabled: true,
      decoration: InputDecoration(
          hintText: "Name",
          hintStyle: TextStyle(fontSize: 20, color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit, color: Colors.white)),
    );
    final tffDescription = TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.white),
      controller: txtDescription,
      enabled: true,
      decoration: InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(fontSize: 20, color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit, color: Colors.white)),
    );
    final tffModel = TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.white),
      controller: txtModel,
      enabled: true,
      decoration: InputDecoration(
          hintText: "Model",
          hintStyle: TextStyle(fontSize: 20, color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit, color: Colors.white)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Card(
        margin: EdgeInsets.fromLTRB(10.0, 25.0, 10, 10),
        color: Colors.white70,
        elevation: 8.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              tffName,
              SizedBox(height: 10),
              tffDescription,
              SizedBox(height: 10),
              tffModel,
              SizedBox(height: 10),
              InkWell(
                //borderRadius: BorderRadius.circular(20.0),
                child: imagePath == null
                    ? Image.network(
                        "https://icoconvert.com/images/noimage2.png",
                        width: 200,
                        height: 200,
                      )
                    : Image.file(File(imagePath)),
                onTap: () async {
                  final PickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    imagePath = PickedFile.path;
                    image = File(PickedFile.path);
                  });
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                  child: Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    await guardarProduct();
                  })
            ],
          ),
        ),
      ),
    );
  }

  guardarProduct() async {
    if (txtName.text.isNotEmpty &&
        txtModel.text.isNotEmpty &&
        txtDescription.text.isNotEmpty &&
        image != null) {
      setState(() {
        loading = true;
      });

      final Reference cFiles =
          FirebaseStorage.instance.ref().child("Products Images");
      final UploadTask uploadImage =
          cFiles.child(txtModel.text.trim()).putFile(image);
      var imageUrl = await (await uploadImage).ref.getDownloadURL();

      await firestore.saveProduct(ProductDAO(
          name: txtName.text,
          model: txtModel.text,
          description: txtDescription.text,
          image: imageUrl));
      setState(() {
        loading = false;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ListProducts()));
    } else {
      showCupertinoDialog<String>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('warning'),
              content: Text('Por favor llena todos los campos'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(context, 'Cancelar'),
                ),
                CupertinoDialogAction(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.pop(context, 'Aceptar'),
                ),
              ],
            );
          });
    }
  }
}
