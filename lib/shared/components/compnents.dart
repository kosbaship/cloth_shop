import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/network/firebase_auth.dart';
import 'package:cloth_shop/network/firebase_storage.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void initApp() {
  FirebaseAuthService();
  FirebaseFireStoreService();
  FirebaseStorageService();
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
            bottom: 0,
            child: Text(
              'Cloths Shop',
              style: TextStyle(
                  fontFamily: 'Pacifico', fontSize: 25, color: kSloganColor),
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
  Color color = kSecondaryColor,
}) =>
    TextField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      cursorColor: kSecondaryColor,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: kGreyColor,
        ),
        prefixIcon: Icon(
          icon,
          color: kSecondaryColor,
        ),
        filled: true,
        fillColor: kMainColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: color)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: color)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: color)),
      ),
    );
Widget writeQuickText(
    {@required String text,
      double fontSize = 16.0,
      Color color = kTextDarkColor,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.center}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        fontFamily: "MontserratRegular",
      ),
    );

Widget drawTextField({
  @required String title,
  @required TextEditingController controller,
  @required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  Function onChange
}) => TextFormField(
  keyboardType: keyboardType,
  obscureText: obscureText,
  controller: controller,
  onChanged: onChange,
  decoration: InputDecoration(
    hintText: "Enter your $title",
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffixIcon: Icon(icon),
    labelText: title,
    labelStyle: TextStyle(
      fontSize: 16.0,
    ),
    hintStyle: TextStyle(color: kGreyColor, fontSize: 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kSloganColor, width: 2),
      gapPadding: 10,
    ),
  ),
  style: TextStyle(fontSize: 14.0, color: kSecondaryColor),
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
// the new button design
Widget buildButton({
  title,
  onPressed,
}) =>
    FlatButton(
      onPressed: onPressed,
      color: kSloganColor,
      textColor: Colors.white,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'BoltSemiBold',
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
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
        Color textColor = kMainColor,
        Color backgroundColor = kSecondaryColor,
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
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
      iconTheme: IconThemeData(
        color: kWhiteColor, //change your color here
      ),
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
Widget buildExpandedCourseItem({
  @required Function startToday,
  @required String price,
  @required ImageProvider<Object> image,
  @required String title,
  @required String startDate,
  @required String description,
  bool initiallyExpanded = false,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        finalPadding: EdgeInsets.zero,
        baseColor: kWhiteColor,
        expandedColor: kWhiteColor,
        initiallyExpanded: initiallyExpanded,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                color: kMainColor,
                image: DecorationImage(image: image, fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // RatingBar.builder(
                      //   initialRating: 4,
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: false,
                      //   itemCount: 5,
                      //   itemSize: 12.0,
                      //   ignoreGestures: true,
                      //   itemPadding: EdgeInsets.zero,
                      //   itemBuilder: (context, _) => Icon(
                      //     Icons.star,
                      //     color: kYellowColor,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: kTextLightColor
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onExpansionChanged: (value) {},
        children: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "Starts at",
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "$startDate",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        writeQuickText(
                            text: "Price",
                            fontSize: 10,
                            textAlign: TextAlign.start),
                        writeQuickText(
                            text: "\$$price",
                            fontSize: 20,
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 160,
                  height: 46.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: kMainColor,
                  ),
                  child: MaterialButton(
                    onPressed: startToday,
                    child: writeQuickText(
                      text: "Start Today",
                      color: kWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );