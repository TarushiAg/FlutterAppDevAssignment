import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'ApiProvider.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();

  //Get Recommendation
  Future<dynamic> getRecommendation(String cursor) async {
    final response = await _apiProvider.get(
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$cursor',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  //Get user details
  Future<dynamic> getUserDetails() async {
    final response = await _apiProvider.get(
      'https://run.mocky.io/v3/3c015c15-d38c-4c51-9738-7692456c4d61',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
