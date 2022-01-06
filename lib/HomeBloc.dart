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

  Stream<dynamic> get recommedationStream => recommendationController.stream;

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
    /*finally {
      recommendationController.close();
    }*/
  }

  dispose() {
    recommendationController?.close();
  }
}
