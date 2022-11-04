import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../../data/models/airLineModel.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of(context);

  late Database database;
  List  airLineFav = [];
  List<AirLineModel>  airLineFav2 = [];

  void iniDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'airLine.db');

    emit(TaskDatabaseInitialized());

    openDataBase(
      path: path,
    );
    emit(TaskDatabaseInitialized());
    print("Database created");
  }

  void getAirLineData() async {
    emit(AppLoadingState());
    airLineFav = [];
    await database.rawQuery('SELECT * FROM airLine').then((value) {
      value.forEach((element) {
        airLineFav.add(element);
      });
      value.forEach((element) {
        //airLineFav2.add(AirLineModel.fromJson(element) );
      });


      print("data done");
      emit(AppDataBaseAirLine());
    });
  }

  void openDataBase({required String path}) async {
    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE airLine (id INTEGER PRIMARY KEY,'
        ' name TEXT, phone TEXT, website TEXT,'
        ' logoUrl TEXT,favorite INTEGER,code TEXT)',
      );
      print("Database created");
    }, onOpen: (Database db) {
      print("Database open");

      database = db;
      getAirLineData();
    });
  }

  void insertDatabase({
    required String? name ,
    required String phone,
    required String site,
    required String logoUrl,
    required String code,
  }) async {
    await database.transaction((txn) async {
      emit(AppLoadingInsertDataBaseState());

    await txn
          .rawInsert(
        'INSERT INTO airLine(name,phone,website,logoUrl,code,favorite) VALUES("${name}","${phone}","${site}","${logoUrl}","${code}",0)',
      ).then((value) {
      print("$value inserted");

    });
    getAirLineData();

      emit(AppInsertDateBaseDone());
    });
  }

  void deleteData({
    required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM airLine WHERE id = ?', [id]).then((value) {
      getAirLineData();
      emit(AppDeleteDataBase());
    });
  }
}
