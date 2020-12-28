import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica5_firebase/src/models/ProdutDAO.dart';

class FirebaseProvider {
  FirebaseFirestore _firestore;
  CollectionReference _productsCollections;

  FirebaseProvider() {
    _firestore = FirebaseFirestore.instance;
    _productsCollections = _firestore.collection('products');
  }

  Future<void> saveProduct(ProductDAO product) {
    return _productsCollections.add(product.toMap());
  }

  Future<void> updateProduct(ProductDAO product, String documentID) {
    return _productsCollections.doc(documentID).update(product.toMap());
  }

  Future<void> removeProduct(String documentID) {
    return _productsCollections.doc(documentID).delete();
  }

  Stream<QuerySnapshot> getAllProducts() {
    return _productsCollections.snapshots();
  }
}
