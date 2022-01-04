import 'package:app_developer_assignment/CustomWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: SvgPicture.asset("images/game_tv.svg")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Username",
                        style: TextStyle(
                            color: kBlackColor, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " *",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))
                  ])),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomWidget().customTextFormField()
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Password",
                        style: TextStyle(
                            color: kBlackColor, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " *",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))
                  ])),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomWidget().customTextFormField()
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(6)),
                        onPressed: () {},
                        color: kPrimaryColor,
                        child: Text("Login"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
