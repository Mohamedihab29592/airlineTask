
 import 'package:equatable/equatable.dart';

import '../../../domain/entities/airlineEntity.dart';

class AirLineState extends Equatable {
 const AirLineState();

  @override
  List<Object?> get props => [];

}
class AirLineInitial extends AirLineState{}
class AirLineLoading extends AirLineState{}
class AirLineLoaded extends AirLineState{
   final List<AirLine> airline;

   const AirLineLoaded({required this.airline});
   @override
   List<Object?> get props => [airline];
}
class AirLineError extends AirLineState{
   final String message;

   const AirLineError({required this.message});
   @override
   List<Object?> get props => [message];
}



