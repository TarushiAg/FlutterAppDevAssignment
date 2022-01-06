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
      'https://userdetails.free.beeceptor.com',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
