import 'package:air_line_task/core/error/faliure.dart';
import 'package:air_line_task/features/domain/entities/airlineEntity.dart';
import 'package:air_line_task/features/domain/repository/baseRepository.dart';
import 'package:dartz/dartz.dart';

class GetAirLineUseCase  {
  final BaseAirLineRepository baseAirLineRepository;

  GetAirLineUseCase({required this.baseAirLineRepository});

  Future<Either<Failure, List<AirLine>>> call() async{

    return await baseAirLineRepository.getAirLineList();
  }
}