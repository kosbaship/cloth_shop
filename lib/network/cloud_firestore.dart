import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_auth.dart';

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

  static Future<DocumentReference> storeUserCartDetails(
      {ProductModel product}) async {
    return await
    fireStoreInstance.collection(kCartCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(kCartDetailsCollection)
        .add({
      kProductImageUrl: product.pImageUrl,
      kProductName: product.pName,
      kProductQuantity: product.pQuantity,
      kProductPrice: product.pPrice
    });
  }

  static Future<DocumentReference> storeOrders({totalPrice, shippingAddress, phone}) async {
    return await fireStoreInstance
        .collection(kOrderCollection).add({
      kUserID: FirebaseAuthService.getUserId(),
      kAddress: shippingAddress,
      kPhone: phone,
      kTotalPrice: totalPrice,
    });
  }
  static storeOrdersDetails({List<ProductModel> products}) async {
    var docReference  = fireStoreInstance
        .collection(kOrderDetailsCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(kOrderDetailsCollection);
    for(var product in products){
      docReference.add({
        kProductImageUrl: product.pImageUrl,
        kProductName: product.pName,
        kProductQuantity: product.pQuantity,
        kProductPrice: product.pPrice
      });
    }
  }

  static Future<QuerySnapshot> getProducts() async {
    return await fireStoreInstance.collection(kProductsCollection).get();
  }

  static Future<QuerySnapshot> getOrders() async {
    return await fireStoreInstance.collection(kOrderCollection).get();
  }
  static Future<QuerySnapshot> getOrdersDetails({@required String userId}) async {
    return await fireStoreInstance
        .collection(kOrderDetailsCollection)
        .doc(userId)
        .collection(kOrderDetailsCollection)
        .get();
  }

  static Future<QuerySnapshot> getCartProducts() async {
    return await fireStoreInstance
        .collection(kCartCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(kCartDetailsCollection)
        .get();
  }

  static deleteUserCart() async {

    getCartProducts().then((value) {
      for (var doc in value.docs) {
        fireStoreInstance
            .collection(kCartCollection)
            .doc(FirebaseAuthService.getUserId())
            .collection(kCartDetailsCollection)
            .doc(doc.id)
            .delete();
      }
    });

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
