import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  static FirebaseFirestore fireStoreInstance;

  FirebaseFireStoreService() {
    fireStoreInstance = FirebaseFirestore.instance;
  }

  static Future<DocumentReference> createCollectionAndAddProduct(
      {ProductModel product, imageUrl}) async {
    return await fireStoreInstance.collection(kProductsCollection).add({
      kProductImageUrl: imageUrl,
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  static Future<QuerySnapshot> getProducts() async {
    return await fireStoreInstance.collection(kProductsCollection).get();
  }

  static Future<void> deleteProduct({documentId}) async {
    return await fireStoreInstance
        .collection(kProductsCollection)
        .doc(documentId)
        .delete();
  }

  static Future<void> editProduct({productData, documentId}) async {
    return await fireStoreInstance
        .collection(kProductsCollection)
        .doc(documentId)
        .update(productData);
  }
}
