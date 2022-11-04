import 'package:air_line_task/core/error/exceptions.dart';
import 'package:air_line_task/core/error/faliure.dart';
import 'package:air_line_task/features/data/dataSource/localDataSource.dart';
import 'package:air_line_task/features/data/dataSource/remoteDataSource.dart';
import 'package:air_line_task/features/domain/entities/airlineEntity.dart';
import 'package:air_line_task/features/domain/repository/baseRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/internetCheck.dart';

class AirLineRepository extends BaseAirLineRepository {
  final AirLineRemoteDateSource airLineRemoteDateSource;
  final AirLineLocalDateSource airLineLocalDateSource;
  final NetworkInfo networkInfo;


  AirLineRepository(
      {required this.networkInfo,
      required this.airLineRemoteDateSource,
      required this.airLineLocalDateSource});

  @override
  Future<Either<Failure, List<AirLine>>> getAirLineList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await airLineRemoteDateSource.getAirLine();
        await airLineLocalDateSource.cachedAirLine(airLineModel: result);
        return Right(result);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final localDataHome = await airLineLocalDateSource.getCachedAirLine();
        return Right(localDataHome);

      }on LocalExceptions{
        return  Left(EmptyCacheFailure());
      }
    }
  }
}

