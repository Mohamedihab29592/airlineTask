import 'package:equatable/equatable.dart';

class AirLine extends Equatable {
final String site;
final String phone;
final String name;
final String logoURL;


const AirLine( {required this.site,  required this.phone, required this.name,
   required this.logoURL});

  @override
  List<Object?> get props => [site,phone,name,logoURL];

}