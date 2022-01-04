import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              borderSide: BorderSide(
                  color: kTextFieldBorderColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kTextFieldBorderColor, width: kTextFieldWidth),
              borderRadius: BorderRadius.circular(6.0)),
          focusColor: kPrimaryColor,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          errorStyle: TextStyle(color: Colors.red.shade400, fontSize: 11),
          counterText: "",
          errorText: errorText,
          contentPadding: EdgeInsets.only(left: 15, right: 15)),
      obscureText: obscureText,
    );
  }
}
