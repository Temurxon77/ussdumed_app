import 'package:flutter/cupertino.dart';
import 'package:uzmobile/bloc/base/base_bloc.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:uzmobile/model/all.dart';
import 'package:rxdart/rxdart.dart';

class InternetBloc extends BaseBloc {
  final _paketi = BehaviorSubject<List<Ism>>();
  Stream<List<Ism>> get paketi => _paketi.stream;

  final _night = BehaviorSubject<List<Ism>>();
  Stream<List<Ism>> get night => _night.stream;

  final _kunlik= BehaviorSubject<List<Ism>>();

  Stream<List<Ism>> get kunlik => _kunlik.stream;

  final _oylik = BehaviorSubject<List<Ism>>();
  Stream<List<Ism>> get oylik => _oylik.stream;
  final _tabs = BehaviorSubject<List<Category>>();
  Stream<List<Category>> get tabs => _tabs.stream;

  List<ValueNotifier>? showButtonsKunlik;
  List<ValueNotifier>? showButtonsOylik;
  List<ValueNotifier>? showButtonsPaketi;
  List<ValueNotifier>? showButtonsNight;

  Future getInternet() async {
    List<Category> tabs = await repo.getInternetTab;
    List<Ism> oylik = await repo.getInternetOylik;
    List<Ism> kunlik = await repo.getInternetKunlik;
    List<Ism> paketi = await repo.getInternetPaketi;
    List<Ism> night = await repo.getInternetNight;
    List<Ism> week = await repo.get

    showButtonsOylik =
        List.generate(oylik.length, (index) => ValueNotifier<bool>(false));
    showButtonsKunlik =
        List.generate(kunlik.length, (index) => ValueNotifier<bool>(false));
    showButtonsPaketi =
        List.generate(paketi.length, (index) => ValueNotifier<bool>(false)); 
        showButtonsNight =
        List.generate(night.length, (index) => ValueNotifier<bool>(false));

    _paketi.sink.add(paketi);
    _night.sink.add(night);
    _kunlik.sink.add(kunlik);
    _oylik.sink.add(oylik);
    _tabs.sink.add(tabs);
  }

  @override
  void dispose() {
    _tabs.close();
    _paketi.close();
    _oylik.close();
    _night.close();
    _kunlik.close();
  }
}
