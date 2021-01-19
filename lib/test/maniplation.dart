import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ManipulateScreen extends StatefulWidget {
  @override
  _ManipulateScreenState createState() => _ManipulateScreenState();
}

class _ManipulateScreenState extends State<ManipulateScreen> {
  Color currentColor = kProductColor;

  void changeColor(Color color) {
    setState(() {
      return currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                print('============================= $currentColor');
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
              width: double.infinity,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 9),
                child: Text(
                  'Choose Color'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                ),
              ),
              color: currentColor,
              textColor: kSecondaryColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(16.0),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: buildDefaultButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Submit',
                                  textColor: kWhiteColor,
                                  backgroundColor: kMainColor,
                                  borderColor: kWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
