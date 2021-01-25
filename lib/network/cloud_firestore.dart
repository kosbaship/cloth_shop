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
      kProductColor: product.pColor,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  static Future<DocumentReference> createCollectionAndAddCart(
      {ProductModel product}) async {
    return await fireStoreInstance.collection(kCartCollection).add({
      kProductImageUrl: product.pImageUrl,
      kProductName: product.pName,
      kProductQuantity: product.pQuantity,
      kProductPrice: product.pPrice
    });
  }

  static Future<QuerySnapshot> getProducts() async {
    return await fireStoreInstance.collection(kProductsCollection).get();
  }

  static Future<QuerySnapshot> getCartProducts() async {
    return await fireStoreInstance.collection(kCartCollection).get();
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
