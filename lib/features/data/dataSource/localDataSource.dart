import 'dart:convert';

import 'package:air_line_task/core/error/faliure.dart';
import 'package:air_line_task/features/data/models/airLineModel.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class AirLineLocalDateSource{
  Future<List<AirLineModel>> getCachedAirLine();
  Future<Unit> cachedAirLine ({required List<AirLineModel> airLineModel});
}


class AirLineLocalDataSourceImp implements AirLineLocalDateSource {
  final SharedPreferences sharedPreferences;

  AirLineLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cachedAirLine({required List<AirLineModel> airLineModel}) {
    List airLineModelToJson = airLineModel.map<Map<String, dynamic>>((
        airLineModel) => airLineModel.toJson()).toList();
    sharedPreferences.setString(
        "Cached_AirLine", json.encode(airLineModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<AirLineModel>> getCachedAirLine() async{
    final jsonString = sharedPreferences.getString("Cached_AirLine");
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<AirLineModel> jsonToAirLineModel = decodeJsonData.map<AirLineModel>((jsonAirLineModel) => AirLineModel.fromJson(jsonAirLineModel)).toList();
      return Future.value(jsonToAirLineModel);
    } else {
      throw  EmptyCacheFailure();
    }


  }


  }



