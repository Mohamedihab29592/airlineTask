

import 'package:air_line_task/core/utilies/constants.dart';
import 'package:air_line_task/features/data/models/airLineModel.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';

abstract class AirLineRemoteDateSource {
  Future<List<AirLineModel>> getAirLine();

}

class AirLineRemoteDataSourceImp implements AirLineRemoteDateSource{
  final Dio dio;

  AirLineRemoteDataSourceImp({required this.dio});

  @override
  Future<List<AirLineModel>> getAirLine() async {
    final response =await dio.get(ApiConstants.aPiBase);
    if(response.statusCode == 200 ){
      final List decodedJson = response.data as List;


    final List<AirLineModel> airLineModel = decodedJson.map<AirLineModel>((jsonAirLineModel)=>AirLineModel.fromJson((jsonAirLineModel))).toList();
    return airLineModel;

  }
else {
  throw ServerExceptions();

}

  }

}