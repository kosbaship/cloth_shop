import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/network/remote/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void initApp() {
  FirebaseAuthService();
}

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
              'Cloths Shop',
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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 9),
        child: Text(
          title,
          style: TextStyle(color: kWhiteColor, fontSize: 14),
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

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateToReplaceMe(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);
void buildProgressDialog({context, text, error = false}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (!error) CircularProgressIndicator(),
                if (!error)
                  SizedBox(
                    width: 20.0,
                  ),
                Expanded(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            if (error) SizedBox(height: 20.0),
            if (error)
              buildDefaultButton(
                onPressed: () => Navigator.pop(context),
                text: "Cancel",
              ),
          ],
        ),
      ),
    );

Widget buildDefaultButton(
        {@required Function onPressed,
        @required String text,
        Color textColor = kWhiteColor,
        Color backgroundColor = kMainColor,
        Color borderColor = kMainColor}) =>
    Container(
      width: double.infinity,
      height: 58.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
          border: Border.all(
            width: 3,
            color: borderColor,
          )),
      child: FlatButton(
        textColor: textColor,
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "MontserratRegular",
          ),
        ),
      ),
    );

Widget drawAppbar(
        {@required context,
        @required actionWidget,
        @required leadingWidget,
        @required title}) =>
    AppBar(
      centerTitle: true,
      backgroundColor: kMainColor,
      title: title,
      leading: leadingWidget,
      actions: [
        actionWidget,
        SizedBox(
          width: 20.0,
        ),
      ],
      elevation: 0.0,
    );
