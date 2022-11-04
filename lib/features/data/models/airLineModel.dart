import '../../domain/entities/airlineEntity.dart';

class AirLineModel extends AirLine {
  const AirLineModel({required super.site,
    required super.phone,
    required super.name,
    required super.logoURL});

  factory AirLineModel.fromJson(Map<String, dynamic> json) {
    return  AirLineModel(
        site: json['site'],
        phone: json['phone'],
        name: json['name'],
        logoURL: json['logoURL'],
      );
}

  Map<String ,dynamic>toJson(){
    return {'site':site ,   'phone':phone, 'name':name ,'logoURL':logoURL};
  }
}
