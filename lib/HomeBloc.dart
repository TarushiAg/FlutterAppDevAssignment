import 'dart:async';

import 'package:app_developer_assignment/Repository.dart';
import 'package:app_developer_assignment/credentials.dart';
import 'package:rxdart/rxdart.dart';

import 'Response.dart';
import 'ValidateStreams.dart';
import 'Validators.dart';

class HomeBloc {
  Repository repository = Repository();
  StreamController recommendationController =
      new BehaviorSubject<Response<dynamic>>();
  StreamController userDetailController =
      new BehaviorSubject<Response<dynamic>>();

  Stream<dynamic> get recommedationStream => recommendationController.stream;
  Stream<dynamic> get userStream => userDetailController.stream;

  //---- get recommendations
  fetchRecommendation(String cursor) async {
    if (recommendationController.isClosed) {
      recommendationController = new BehaviorSubject<Response<dynamic>>();
    }
    try {
      dynamic response = await repository.getRecommendation(cursor);
      recommendationController.sink.add(Response.completed(response));
    } catch (e) {
      recommendationController.sink.add(Response.error(e.toString()));
      print(e);
    }
  }

  //---- get user detaials
  getUserDetails() async {
    if (userDetailController.isClosed) {
      userDetailController = new BehaviorSubject<Response<dynamic>>();
    }
    try {
      dynamic response = await repository.getUserDetails();
      userDetailController.sink.add(Response.completed(response));
    } catch (e) {
      userDetailController.sink.add(Response.error(e.toString()));
      print(e);
    }
  }

  clearRecommendationStream() {
    recommendationController.sink.add(null);
  }

  clearUserStream() {
    userDetailController.sink.add(null);
  }

  dispose() {
    recommendationController?.close();
    userDetailController?.close();
  }
}
