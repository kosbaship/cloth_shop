import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  static FirebaseFirestore fireStore;

  FirebaseFireStoreService() {
    fireStore = FirebaseFirestore.instance;
  }

  static Future<DocumentReference> createCollectionAndAddProduct(
      {ProductModel product}) async {
    return await fireStore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  // this to get a stream
  static List<QueryDocumentSnapshot> getProducts() {
    var queryDocs;
    fireStore.collection(kProductsCollection).snapshots().listen((event) {
      queryDocs = event.docs;
    });
    return queryDocs;
  }

  static Future<void> deleteProduct({documentId}) async {
    return await fireStore
        .collection(kProductsCollection)
        .doc(documentId)
        .delete();
  }

  static Future<void> editProduct({productData, documentId}) async {
    return await fireStore
        .collection(kProductsCollection)
        .doc(documentId)
        .update(productData);
  }
}
