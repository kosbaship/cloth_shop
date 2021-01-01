import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget showLogo({@required screenHeight}) => Container(
      height: screenHeight * .2,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/icons/buyicon.png'),
          ),
          Positioned(
            bottom: -10,
            child: Text(
              'Cloth Shop',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
            ),
          ),
          SizedBox(
            width: double.infinity,
          ),
        ],
      ),
    );
Widget buildTextField({
  @required TextEditingController controller,
  @required icon,
  @required hint,
  @required TextInputType type,
  bool isPassword = false,
}) =>
    TextField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      cursorColor: kMainColor,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: kMainColor,
        ),
        filled: true,
        fillColor: kSecondaryColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kWhiteColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kWhiteColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kWhiteColor)),
      ),
    );

Widget buildBtn({@required Function function, @required String title}) =>
    FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: function,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          title,
          style: TextStyle(color: kWhiteColor, fontSize: 18),
        ),
      ),
    );

showToast({@required String message, @required bool error}) =>
    Fluttertoast.showToast(
        msg: " $message ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
