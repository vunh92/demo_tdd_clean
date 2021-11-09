import 'dart:convert';

import 'package:demo_tdd_clean/core/error/exceptions.dart';
import 'package:demo_tdd_clean/features/upcoming/data/models/upcoming_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UpcomingLocalDataSource {
  Future<List<UpcomingModel>> getLastUpcoming();
  Future<List<UpcomingModel>> getLastUpcomingList();

  Future<void> cacheUpcoming(List<UpcomingModel> upcomingToCache);
  Future<void> cacheUpcomingList(List<UpcomingModel> upcomingToCache);
}

const CACHED_UPCOMING = 'CACHED_UPCOMING';
const CACHED_UPCOMING_LIST = 'CACHED_UPCOMING_LIST';

class UpcomingLocalDataSourceImpl implements UpcomingLocalDataSource{
  final SharedPreferences sharedPreferences;

  UpcomingLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<List<UpcomingModel>> getLastUpcoming() {
    final jsonString = sharedPreferences.getString(CACHED_UPCOMING);
    if (jsonString != null) {
      return Future.value(((json.decode(jsonString) as List).map((json) => UpcomingModel.fromJsonLocal(json))).toList());
      // return Future.value(UpcomingModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<UpcomingModel>> getLastUpcomingList() {
    final jsonString = sharedPreferences.getString(CACHED_UPCOMING_LIST);
    if (jsonString != null) {
      return Future.value(((json.decode(jsonString) as List).map((json) => UpcomingModel.fromJsonLocal(json))).toList());
      // return Future.value(UpcomingModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUpcomingList(List<UpcomingModel> upcomingToCache) {
    // String upcomingList = jsonEncode(upcomingToCache.map<Map<String, dynamic>>((upcoming) => UpcomingModel.toJsonList(upcoming: upcoming)).toList());
    return sharedPreferences.setString(
      CACHED_UPCOMING_LIST,
      json.encode(upcomingToCache),
    );
  }

  @override
  Future<void> cacheUpcoming(List<UpcomingModel> upcomingToCache) {
    // String upcomingList = jsonEncode(upcomingToCache.map<Map<String, dynamic>>((upcoming) => UpcomingModel.toJsonList(upcoming: upcoming)).toList());
    return sharedPreferences.setString(
      CACHED_UPCOMING,
      json.encode(upcomingToCache),
    );
  }

}