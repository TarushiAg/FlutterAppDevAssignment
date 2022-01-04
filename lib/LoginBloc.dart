import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'Response.dart';
import 'ValidateStreams.dart';
import 'Validators.dart';

class LoginBloc extends Object with Validators {
  BehaviorSubject loginFetcher = new BehaviorSubject<Response<dynamic>>();

  final usernameController = new BehaviorSubject<String>();
  final passwordController = new BehaviorSubject<String>();

  ValidateAllStreamsHaveDataAndNoErrors _validateAllStreamsHaveDataAndNoErrors;

  Function(String) get usernameChange => usernameController.sink.add;
  Function(String) get passwordChange => passwordController.sink.add;

  Stream<String> get username =>
      usernameController.stream.transform(passwordValidator);
  Stream<String> get password =>
      passwordController.stream.transform(passwordValidator);

  Stream<bool> get loginCheck => _validateAllStreamsHaveDataAndNoErrors.status;

  LoginBloc() {
    _validateAllStreamsHaveDataAndNoErrors =
        ValidateAllStreamsHaveDataAndNoErrors()..listen([username, password]);
  }

  //---- get login Data
  getLoginData() async {
    if (loginFetcher.isClosed) {
      loginFetcher = new BehaviorSubject<Response<dynamic>>();
    }
    try {
      // loginFetcher.sink.add(
      //     Response.completed(LoginFnacResponseModel.fromJson(responseModel)));
    } catch (e) {
      loginFetcher.sink.add(Response.error(e.toString()));
      print(e);
    } finally {
      loginFetcher.close();
    }
  }

  dispose() {
    loginFetcher?.close();
    usernameController?.close();
    passwordController?.close();
  }
}
