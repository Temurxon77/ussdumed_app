import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uzmobile/bloc/internet_bloc.dart';
import 'package:uzmobile/model/all.dart';
import 'package:uzmobile/ui/widget/balance_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzmobile/utils/helperFunctions.dart';

class InternetPage extends StatefulWidget {
  @override
  _InternetPageState createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  final bloc = InternetBloc();


  @override
  void initState() {
    bloc.getInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),onPressed: () async => await popPage(context: context)),
          title: Text("internet".tr().toUpperCase()),
        ),
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: StreamBuilder<List<Category>>(
                stream: bloc.tabs,
                builder: (context, snapshot) {
                  bool? isRu = context.locale.languageCode == "ru";
                  if(snapshot.hasData)
                  return TabBar(isScrollable: true,
                    labelColor: Colors.black,
                  tabs: List.generate(snapshot.data!.length, (index) =>  Tab(
                    child: Text(isRu ? snapshot.data![index].catUz ?? "" : snapshot.data![index].catRu ?? ""),
                  ))
                  );
                  else return const SizedBox();
                }
              )
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder<List<Ism>>(
                      stream: bloc.paketi,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return customTab(
                              snapshot.data, bloc.showButtonsPaketi);
                        else
                          return const SizedBox();
                      }),
                  StreamBuilder<List<Ism>>(
                      stream: bloc.night,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return customTab(
                              snapshot.data, bloc.showButtonsNight);
                        else
                          return const SizedBox();
                      }),
                  StreamBuilder<List<Ism>>(
                      stream: bloc.kunlik,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return customTab(
                              snapshot.data, bloc.showButtonsKunlik);
                        else
                          return const SizedBox();
                      }),
                       StreamBuilder<List<Ism>>(
                      stream: bloc.oylik,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return customTab(
                              snapshot.data, bloc.showButtonsOylik);
                        else
                          return const SizedBox();
                      })
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget customTab(List<Ism>? data, showButtons) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
//                  if (data.category[index].catUz != null && data.category[index].catUz != '')
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisSize: MainAxisSize.min,
//                      children: [
//                        SizedBox(
//                          height: 8,
//                        ),
//                        Text(
//                          context.locale.languageCode == 'ru'
//                              ? data.category[index].catRu
//                              : data.category[index].catUz,
//                          style:
//                              TextStyle(color: Theme.of(context).primaryColor),
//                        ),
//                        Divider()
//                      ],
//                    )
//                  else
//                    Container(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                showButtons[index].value = !showButtons[index].value;
                              },
                              leading: Text(data?[index].titleRu ?? ""),
                              trailing: Text(
                                data?[index].price ?? "",
                                style: TextStyle(color: Colors.indigo.shade900)
                              )
                            ),
                            ValueListenableBuilder(
                                valueListenable: showButtons[index],
                                builder: (ctx, v, w) {
                                  if (v != null)
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showButtons[index].value =
                                                  !showButtons[index].value;
                                            },
                                            child: SizedBox(
                                              child: Text(
                                                  context.locale.languageCode == 'ru'
                                                      ? data![index]
                                                          .descRu
                                                          !.replaceAll('<br>', '\n')
                                                      : data![index]
                                                          .descUz
                                                          !.replaceAll('<br>', '\n')),
                                            ),
                                          ),
                                          BalanceButton(
                                            title: "buy".tr().toUpperCase(),
                                            onPressed: () async {
                                              String urlString =
                                                  'tel:${data[index].kod}#';
                                              if (await canLaunch(urlString)) {
                                                await FlutterPhoneDirectCaller.callNumber(urlString);
                                              }
                                            }
                                          )
                                        ]
                                      )
                                    );
                                  else
                                    return const SizedBox();
                                })
                          ]
                        )
                      ]
                    );
                  })
            ),
            StreamBuilder<List<Category>>(
                stream: bloc.tabs,
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BalanceButton(title:"check_rest".tr(),onPressed: () async{
                        await FlutterPhoneDirectCaller.callNumber("${snapshot.data?[0].kod}#");
                      })
                    );
                  else return const SizedBox();
                }
            )
          ]
        )
      )
    );
  }
}
