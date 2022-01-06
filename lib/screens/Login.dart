import 'package:app_developer_assignment/util/CustomWidget.dart';
import 'package:app_developer_assignment/blocs/LoginBloc.dart';
import 'package:app_developer_assignment/util/Response.dart';
import 'package:app_developer_assignment/util/SharedPreferenceUtils.dart';
import 'package:app_developer_assignment/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_developer_assignment/screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //game tv logo
                Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.17),
                    child: SvgPicture.asset(
                      "images/game_tv.svg",
                      height: MediaQuery.of(context).size.height * 0.12,
                    )),

                //username
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<String>(
                        stream: loginBloc.username,
                        builder: (context, snapshot) {
                          String errorMsg;
                          if (snapshot.hasError) {
                            errorMsg =
                                "Username should have length more than 3 and less than 11";
                          }
                          return CustomWidget().customTextFormField(
                              errorText: errorMsg,
                              onChanged: loginBloc.usernameChange,
                              hintText: "Username",
                              maxLines: 1);
                        }),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),

                //password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<String>(
                        stream: loginBloc.password,
                        builder: (context, snapshot) {
                          String errorMsg;
                          if (snapshot.hasError) {
                            errorMsg =
                                "Password should have length more than 3 and less than 11";
                          }

                          return CustomWidget().customTextFormField(
                            obscureText: true,
                            errorText: errorMsg,
                            hintText: "Password",
                            maxLines: 1,
                            onChanged: loginBloc.passwordChange,
                          );
                        }),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),

                StreamBuilder<bool>(
                    stream: loginBloc.loginCheck,
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              child: RaisedButton(
                                color: kPrimaryColor,
                                child: Text("Login"),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(6)),
                                elevation: 1,
                                onPressed: snapshot.hasData && snapshot.data
                                    ? () {
                                        setState(() {
                                          loginBloc.tryLogin();
                                          loginBloc.loginFetcher
                                              .listen((value) {
                                            Response<dynamic> result = value;
                                            switch (result.status) {
                                              case Status.LOADING:
                                                break;
                                              case Status.COMPLETED:
                                                bool loginSuccess = result.data;
                                                if (loginSuccess) {
                                                  PreferenceUtils.putString(
                                                      PreferenceUtils
                                                          .KEY_CUSTOMER_USERNAME,
                                                      loginBloc
                                                          .usernameController
                                                          .value);
                                                  PreferenceUtils.putString(
                                                      PreferenceUtils
                                                          .KEY_CUSTOMER_PASSWORD,
                                                      loginBloc
                                                          .passwordController
                                                          .value);
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomeScreen(),
                                                    ),
                                                    (Route route) => false,
                                                  );
                                                } else {
                                                  CustomWidget().getCustomAlertDialog(
                                                      context,
                                                      "Incorrect Credentials",
                                                      "Please enter correct username and password");
                                                }
                                                break;
                                              case Status.ERROR:
                                                CustomWidget()
                                                    .getCustomAlertDialog(
                                                        context,
                                                        "Alert!",
                                                        "Something went wrong!");
                                                break;
                                            }
                                          });
                                        });
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
