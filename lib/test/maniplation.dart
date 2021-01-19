import 'dart:io';

import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManipulateScreen extends StatefulWidget {
  @override
  _ManipulateScreenState createState() => _ManipulateScreenState();
}

class _ManipulateScreenState extends State<ManipulateScreen> {
  String imageLink;
  File imageFileFromUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageLink != null
                ? CircleAvatar(
                    radius: 110,
                    backgroundColor: kMainColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.file(
                          File(imageLink),
                          fit: BoxFit.fill,
                        ),
                      ),
                      radius: 100,
                    ),
                  )
                : FlatButton(
                    onPressed: () {
                      selectImage();
                      print('============================= start');
                    },
                    color: kSecondaryColor,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.camera,
                          size: 120,
                          color: kMainColor,
                        ),
                        Text(
                          "Choose Image",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: kTextLightColor,
                              ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: buildDefaultButton(
                  onPressed: () {
                    uploadImage();
                  },
                  text: 'Submit',
                  textColor: kWhiteColor,
                  backgroundColor: kMainColor,
                  borderColor: kWhiteColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: buildDefaultButton(
                  onPressed: () {
                    setState(() {});
                  },
                  text: 'Set  State',
                  textColor: kWhiteColor,
                  backgroundColor: kMainColor,
                  borderColor: kWhiteColor),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }

  selectImage() {
    ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) {
      imageFileFromUser = File(pickedFile.path);
      print(pickedFile.path);
      imageLink = pickedFile.path;
      setState(() {});
    });
  }

  uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'PicsForTest/${Uri.file(imageFileFromUser.path).pathSegments.last}')
        .putFile(imageFileFromUser)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('PicsForTestPath')
            .add({'imageUrl': value.toString()});
        print('=========================== DOne');
      });
    });
  }
}
