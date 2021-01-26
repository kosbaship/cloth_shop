import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<DocumentReference> createCollectionAndAddCart(
      {ProductModel product}) async {
    return await
    fireStoreInstance.collection(kUserDetailsCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(kUserCartCollection)
        .add({
      kProductImageUrl: product.pImageUrl,
      kProductName: product.pName,
      kProductQuantity: product.pQuantity,
      kProductPrice: product.pPrice
    });
  }

  static storeOrders(
      {List<ProductModel> products, totalPrice, shippingAddress, phone}) async {

    var docReference  = fireStoreInstance.collection(kOrderCollection).doc();
    docReference.set({
      'userID': FirebaseAuthService.getUserId(),
      kAddress: shippingAddress,
      kPhone: phone,
      kTotalPrice: totalPrice,
    });
    for(var product in products){
      docReference.collection(kOrderDetailsCollection).doc().set({
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

  static Future<QuerySnapshot> getCartProducts() async {
    return await fireStoreInstance
        .collection(kUserDetailsCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(kUserCartCollection)
        .get();
  }

  static deleteUserCart() async {
    print('--------$kUserDetailsCollection');
    print('--------${FirebaseAuthService.getUserId()}');

    getCartProducts().then((value) {
      for (var doc in value.docs) {
        print('--------${doc.id}');
        fireStoreInstance
            .collection(kUserDetailsCollection)
            .doc(FirebaseAuthService.getUserId())
            .collection(kUserCartCollection)
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
