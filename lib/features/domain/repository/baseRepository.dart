import 'package:air_line_task/features/domain/entities/airlineEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';

abstract class BaseAirLineRepository{
  Future<Either<Failure,List<AirLine>>> getAirLineList();

}