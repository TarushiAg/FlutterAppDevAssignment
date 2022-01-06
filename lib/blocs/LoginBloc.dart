import 'dart:async';

import 'package:app_developer_assignment/util/Response.dart';
import 'package:app_developer_assignment/util/credentials.dart';
import 'package:rxdart/rxdart.dart';

import '../util/ValidateStreams.dart';
import '../util/Validators.dart';

class LoginBloc extends Object with Validators {
  BehaviorSubject loginFetcher = new BehaviorSubject<Response<dynamic>>();

  final usernameController = new BehaviorSubject<String>();
  final passwordController = new BehaviorSubject<String>();

  ValidateAllStreamsHaveDataAndNoErrors _validateAllStreamsHaveDataAndNoErrors;

  Function(String) get usernameChange => usernameController.sink.add;
  Function(String) get passwordChange => passwordController.sink.add;

  Stream<String> get username =>
      usernameController.stream.transform(lengthValidator);
  Stream<String> get password =>
      passwordController.stream.transform(lengthValidator);

  Stream<bool> get loginCheck => _validateAllStreamsHaveDataAndNoErrors.status;

  LoginBloc() {
    _validateAllStreamsHaveDataAndNoErrors =
        ValidateAllStreamsHaveDataAndNoErrors()..listen([username, password]);
  }

  //---- login
  tryLogin() async {
    if (loginFetcher.isClosed) {
      loginFetcher = new BehaviorSubject<Response<dynamic>>();
    }
    try {
      String username = usernameController.value;
      String password = passwordController.value;

      Credentials.usernamePasswordMap.containsKey(username)
          ? Credentials.usernamePasswordMap[username] == password
              ? loginFetcher.sink.add(Response.completed(true))
              : loginFetcher.sink.add(Response.completed(false))
          : loginFetcher.sink.add(Response.completed(false));
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
