/* 
@Authour: Islomkuja Akhrorov
Created at: 7/13/20
*/
import 'package:uzmobile/data/api.dart';
import 'package:uzmobile/data/database.dart';
import 'package:uzmobile/model/all.dart';

class Repository {
  static final Repository _repository = Repository._();
  static int companyID = 1;

  Repository._();

  factory Repository() => _repository;
  Api _api = Api();
  DatabaseProvider _db = DatabaseProvider();

  Future<All> get getAllData => _api.getAllData();
  Future<String> getNews(String localization) => _api.getNews(localization);

  /// DATABASE
  Future<List<Tarifs>> getTarifs() => _db.getTarifs(companyID: companyID);

  Future<List<Ism>> getIsms() => _db.getIsms(companyID: companyID);
  Future<List<Category>> getCategory() => _db.getCategory(companyID: companyID);

  Future<List<Ism>> get getMinuteSms => _db.getMinuteSms(companyID: companyID);
  Future<List<Category>> get getMinuteSmsCategory => _db.getMinuteSmsCategory(companyID: companyID);

  Future<List<Ism>> get getInternetWeek => _db.getInternetWeek(companyID: companyID);
  Future<List<Ism>> get getInternetOylik => _db.getInternetOylik(companyID: companyID);

  Future<List<Ism>> get getInternetKunlik => _db.getInternetKunlik(companyID: companyID);
  Future<List<Ism>> get getInternetNight => _db.getInternetNight(companyID: companyID);


  Future<List<Ism>> get getInternetPaketi => _db.getInternetPaketi(companyID: companyID);
  Future<List<Category>> get getInternetTab => _db.getInternetTab(companyID: companyID);

  Future<int> insertTarifs(Tarifs table) => _db.insertTarifs(table);

  Future<int> insertIsm(Ism table) => _db.insertIsm(table);
  Future<int> insertCategory(Category table) => _db.insertCategory(table);

  Future<int> updateTarifs(Tarifs table) => _db.updateTarifs(table);

  Future<int> updateIsm(Ism table) => _db.updateIsm(table);
  Future<int> updateCategory(Category table) => _db.updateCategory(table);
}
