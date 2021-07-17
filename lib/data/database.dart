/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:uzmobile/model/all.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uzmobile/utils/constants.dart';

enum TarifsEnum {
  id,
  name,
  title_uz,
  title_ru,
  kod,
  photo,
  descr_uz,
  descr_ru,
  summa,
  status,
  torder,
  companyid
}
enum IsmEnum {
  id,
  price,
  title_uz,
  title_ru,
  kod,
  catid,
  type,
  desc_uz,
  desc_ru,
  status,
  companyid
}
enum CategoryEnum { id, cat_uz, cat_ru, kod, torder, type,companyid }

class DatabaseProvider {
  static final DatabaseProvider _db = DatabaseProvider._();

  DatabaseProvider._();

  factory DatabaseProvider() => DatabaseProvider._db;
  Database? db;

  Future open() async {
    //print(TarifsEnum.id.toString());
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'uzmobile.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE ${Tarifs.tableName} ( 
  ${TarifsEnum.id.toString().split('.').last} INTEGER PRIMARY KEY AUTOINCREMENT , 
  ${TarifsEnum.name.toString().split('.').last} text ,
  ${TarifsEnum.title_uz.toString().split('.').last} text ,
  ${TarifsEnum.title_ru.toString().split('.').last} text ,
  ${TarifsEnum.kod.toString().split('.').last} text ,
  ${TarifsEnum.photo.toString().split('.').last} text ,
  ${TarifsEnum.descr_uz.toString().split('.').last} text ,
  ${TarifsEnum.descr_ru.toString().split('.').last} text ,
  ${TarifsEnum.status.toString().split('.').last} text ,
  ${TarifsEnum.torder.toString().split('.').last} text ,
  ${TarifsEnum.summa.toString().split('.').last} text ,
  ${TarifsEnum.companyid.toString().split('.').last} text)
''');
      await db.execute('''
create table ${Ism.tableName} ( 
  ${IsmEnum.id.toString().split('.').last} integer primary key autoincrement, 
  ${IsmEnum.price.toString().split('.').last} text ,
  ${IsmEnum.title_uz.toString().split('.').last} text ,
  ${IsmEnum.title_ru.toString().split('.').last} text ,
  ${IsmEnum.kod.toString().split('.').last} text ,
  ${IsmEnum.catid.toString().split('.').last} text ,
  ${IsmEnum.type.toString().split('.').last} text ,
  ${IsmEnum.desc_uz.toString().split('.').last} text ,
  ${IsmEnum.desc_ru.toString().split('.').last} text ,
  ${IsmEnum.companyid.toString().split('.').last} text,
  ${IsmEnum.status.toString().split('.').last} text )
''');
      await db.execute('''
create table ${Category.tableName} ( 
  ${CategoryEnum.id.toString().split('.').last} integer primary key autoincrement, 
  ${CategoryEnum.cat_uz.toString().split('.').last} text ,
  ${CategoryEnum.cat_ru.toString().split('.').last} text ,
  ${CategoryEnum.kod.toString().split('.').last} text ,
  ${CategoryEnum.torder.toString().split('.').last} text ,
  ${CategoryEnum.companyid.toString().split('.').last} text ,
  ${CategoryEnum.type.toString().split('.').last} text  )
''');
    });
  }

  Future<int> insertIsm(Ism table) async {
    await open();
    try {
      int result = await db!.insert(Ism.tableName, table.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await close();
      return result;
    } on DatabaseException catch (e) {
      print(e);
      updateIsm(table);
      return 100;
    }
  }

  Future<int> insertCategory(Category table) async {
    await open();
    try {
      int result = await db!.insert(Category.tableName, table.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await close();
      return result;
    } on DatabaseException catch (e) {
      print(e);
      updateCategory(table);
      return 100;
    }
  }

  Future<int> insertTarifs(Tarifs table) async {
    await open();
    try {
      int result = await db!.insert(Tarifs.tableName, table.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await close();
      return result;
    } on DatabaseException catch (e) {
      print(e);
      updateTarifs(table);
      return 100;
    }
  }

  Future<List<Tarifs>> getTarifs({int? companyID}) async {
    print(companyID);
    //final String companyCol = TarifsEnum.companyid.toString().split('.').last;
    await open();
    List<Map<String,dynamic>> maps = await db!.rawQuery(
      """ SELECT * FROM ${Tarifs.tableName} WHERE companyid = $companyID"""
    );
    await close();

    if (maps.length > 0) {
      return maps.map((e) => Tarifs.fromJson(e)).toList();
    }

    return [];
  }

  Future<List<Ism>> getIsms({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Ism.tableName,
      where: "companyid = ?",
      whereArgs: [companyID]
    );
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Category>> getCategory({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Category.tableName,
      where: "companyid = ?",
      whereArgs: [companyID]
    );
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ism>> getMinuteSms({int? companyID}) async {
    await open();
    // List<Map<String,dynamic>>? maps = await db!.query(
    //   Ism.tableName,
    //   where: """
    //   ${IsmEnum.catid.toString().split('.').last}='20'
    //   or
    //   ${IsmEnum.catid.toString().split('.').last}='24'
    //   or
    //   ${IsmEnum.catid.toString().split('.').last}='26'
    //   AND companyid = $companyID ;
    //   """,
    // );
    //print(companyID);
    List<Map<String,dynamic>>? maps = await db!.query(
      Ism.tableName,
      where: """
      ${IsmEnum.catid.toString().split('.').last} = ${catID[companyID]![0]}
      or
      ${IsmEnum.catid.toString().split('.').last} = ${catID[companyID]![1]}
      or
      ${IsmEnum.catid.toString().split('.').last} = ${catID[companyID]![2]}
      AND companyid = $companyID ;
      """,
    );
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Category>> getMinuteSmsCategory({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Category.tableName,
      where: """
      ${CategoryEnum.type.toString().split('.').last}='1'
      or
      ${CategoryEnum.type.toString().split('.').last}='2'
      AND companyid = $companyID ;
      """,
    );
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ism>> getInternetKunlik({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Ism.tableName,
      where: "${IsmEnum.catid.toString().split('.').last}='16' AND companyid = $companyID ;",
    );
    //print("onnet : ${maps}");
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Category>> getInternetTab({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Category.tableName,
      where: "${CategoryEnum.type.toString().split('.').last}='0' AND companyid = $companyID",
    );
   // print("onnet : ${maps}");
    await close();
    if (maps.length > 0) {
      return maps.map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ism>> getInternetOylik({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(Ism.tableName,
        where: "${IsmEnum.catid.toString().split('.').last}='17' AND companyid = $companyID ;");
    //print("night : ${maps}");

    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }
  Future<List<Ism>> getInternetWeek({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(Ism.tableName,
        where: "${IsmEnum.catid.toString().split('.').last}='17' AND companyid = $companyID ;");
    //print("night : ${maps}");

    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }


  Future<List<Ism>> getInternetPaketi({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Ism.tableName,
      where: "${IsmEnum.catid.toString().split('.').last}='14' AND companyid = $companyID",
    );
    //print("paketi : ${maps}");

    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Ism>> getInternetNight({int? companyID}) async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(
      Ism.tableName,
      where: "${IsmEnum.catid.toString().split('.').last}='15' AND companyid = $companyID ;",
    );
    //print("paketi : ${maps}");

    await close();
    if (maps.length > 0) {
      return maps.map((e) => Ism.fromJson(e)).toList();
    }
    return [];
  }

  Future<int> updateIsm(Ism table) async {
    await open();
    int result = await db!.update(
      Ism.tableName,
      table.toJson(),
    );
    await close();
    return result;
  }

  Future<int> updateTarifs(Tarifs table) async {
    await open();
    int result = await db!.update(
      Tarifs.tableName,
      table.toJson()
    );
    await close();
    return result;
  }

  Future<int> updateCategory(Category table) async {
    await open();
    int result = await db!.update(
      Category.tableName,
      table.toJson()
    );
    await close();
    return result;
  }

  Future close() async => db!.close();
}
