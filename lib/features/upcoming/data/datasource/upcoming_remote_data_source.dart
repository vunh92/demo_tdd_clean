import 'dart:convert';

import 'package:demo_tdd_clean/core/error/exceptions.dart';
import 'package:demo_tdd_clean/features/upcoming/data/models/upcoming_model.dart';
import 'package:http/http.dart' as http;


abstract class UpcomingRemoteDataSource {
  Future<List<UpcomingModel>> getUpcoming();
  Future<List<UpcomingModel>> getUpcomingId(int number);
}

class UpcomingRemoteDataSourceImpl implements UpcomingRemoteDataSource {
  final http.Client client;

  UpcomingRemoteDataSourceImpl({this.client});

  @override
  Future<List<UpcomingModel>> getUpcomingId(int number) {
    return _getUpcomingFromUrl('https://api.themoviedb.org/3/movie/$number?api_key=d79d9f8467a0e6d7b24624c522cb2ab3');
    // return _getUpcomingFromUrl('https://api.themoviedb.org/3/movie/580489?api_key=d79d9f8467a0e6d7b24624c522cb2ab3');
  }

  @override
  Future<List<UpcomingModel>> getUpcoming() {
    return _getUpcomingListFromUrl('https://api.themoviedb.org/3/movie/upcoming?api_key=d79d9f8467a0e6d7b24624c522cb2ab3');
  }

  Future<List<UpcomingModel>> _getUpcomingFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // return ((json.decode(response.body)).map((json) => UpcomingModel.fromJson(json))).toList();
      return [UpcomingModel.fromJson(json.decode(response.body))];
    } else {
      throw ServerException();
    }
  }

  Future<List<UpcomingModel>> _getUpcomingListFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results'] as List).map((json) => UpcomingModel.fromJson(json))).toList();
    } else {
      throw ServerException();
    }
  }
}