
import 'package:air_line_task/core/utilies/appStrings.dart';
import 'package:air_line_task/features/domain/useCase/airLineUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/faliure.dart';
import '../../../domain/entities/airlineEntity.dart';
import '../../screens/airLineFavScreen.dart';
import '../../screens/airLineList.dart';
import 'air_line_event.dart';
import 'air_line_state.dart';



class AirLineBloc extends Bloc<AirLineEvent, AirLineState> {
  static AirLineBloc get(context) => BlocProvider.of(context);

  final GetAirLineUseCase getAirLineUseCase;

  AirLineBloc({required this.getAirLineUseCase}) : super( AirLineInitial())

  {
    on<AirLineEvent>((event, emit) async {
      emit(AirLineLoading());
      if (event is GetAirLineEvent) {
        final failureOrAirline = await getAirLineUseCase();
        emit(_mapFailureOrAirLine(failureOrAirline));
      }
    });
  }

  AirLineState _mapFailureOrAirLine(Either<Failure, List<AirLine>> either) {
   return either.fold((l) => AirLineError(message: _mapFailureToMsg(l)), (r) =>
        AirLineLoaded(airline: r));
  }


  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case EmptyCacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offline;
      default:
        return AppStrings.unExpectedError;
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const AirLineList(),
    const AirLineFavScreen(),

  ];

  changeBottomNav(index) {
    currentIndex = index;
  }



}

