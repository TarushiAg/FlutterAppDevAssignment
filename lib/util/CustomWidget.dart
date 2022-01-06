import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class CustomWidget {
  Widget customTextFormField(
      {hintText,
      errorText,
      trailingIcon,
      obscureText = false,
      onChanged,
      controller,
      maxLength,
      enabled = true,
      maxLines = 1,
      textDirection,
      onTap}) {
    return TextFormField(
      maxLines: maxLines,
      onTap: onTap,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      textDirection: textDirection,
      decoration: InputDecoration(
          suffixIcon: trailingIcon,
          suffixIconConstraints: BoxConstraints(
            maxHeight: 25,
            maxWidth: 25,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kPrimaryColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kTextFieldBorderColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kTextFieldBorderColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kErrorTextFieldColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kErrorTextFieldColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          focusColor: kPrimaryColor,
          hintText: hintText,
          hintStyle: TextStyle(color: kHintColorTextField),
          errorStyle: TextStyle(color: kErrorTextFieldColor, fontSize: 11),
          counterText: "",
          errorText: errorText,
          /*border: new OutlineInputBorder(
            borderSide: BorderSide(width: kTextFieldWidth),
            borderRadius: new BorderRadius.circular(6.0),
          ),*/
          contentPadding: EdgeInsets.only(left: 15, right: 15)),
      obscureText: obscureText,
    );
  }

  getCustomAlertDialog(BuildContext context, String title, String msg,
      {bool isRetry, Function onRetryPressed}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: new Text('${title}'),
                content: Text('${msg}'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('Ok'),
                  )
                ],
              ),
            ));
  }
}
