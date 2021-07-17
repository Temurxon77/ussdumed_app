import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uzmobile/bloc/minute_sms_bloc.dart';
import 'package:uzmobile/model/all.dart';
import 'package:uzmobile/ui/widget/balance_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzmobile/utils/helperFunctions.dart';

class MinuteSmsPage extends StatefulWidget {
  @override
  _MinuteSmsPageState createState() => _MinuteSmsPageState();
}

class _MinuteSmsPageState extends State<MinuteSmsPage> {
  final bloc = MinuteSmsBloc();

  @override
  void initState() {
    bloc.getMinuteSms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),onPressed: () async => await popPage(context: context)),
        title: Text("minute_sms".tr().toUpperCase())
      ),
      body: StreamBuilder<All>(
          stream: bloc.minuteSms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    addRepaintBoundaries: false,
                    addAutomaticKeepAlives: false,
                    itemCount: snapshot.data!.ism!.length,
                    itemBuilder: (context, index) {
                      // bloc.prev = bloc.curr;
                      // bloc.curr = snapshot.data!.ism![index].catid;
                      // print("Bloc1: ${bloc.i}");
                      // if (bloc.prev != bloc.curr) bloc.i += 1;
                      // print("Bloc2: ${bloc.i}");
                      return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (bloc.prev != bloc.curr)
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                        height: 8
                                    ),
                                    Text(
                                        context.locale.languageCode == 'ru'
                                            ? snapshot.data!.category![bloc.i].catRu ?? ""
                                            : snapshot.data!.category![bloc.i].catUz ?? "",
                                        style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .primaryColor)
                                    ),
                                    const Divider(),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BalanceButton(
                                            title: "check_rest".tr(),
                                            onPressed: () async {
                                              await FlutterPhoneDirectCaller.callNumber(
                                                  "${snapshot.data!.category![bloc.i].kod}#");
                                            }
                                        )
                                    )
                                  ]
                              )
                            else
                              const SizedBox(),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                      onTap: () {
                                        bloc.showButtons![index].value =
                                        !bloc.showButtons![index].value;
                                      },
                                      leading: Text(
                                          context.locale.languageCode == 'ru'
                                              ? snapshot.data!.ism![index].titleRu ?? ""
                                              : snapshot.data!.ism![index].titleUz ?? ""),
                                      trailing: Text(
                                        snapshot.data!.ism![index].price ?? "",
                                        style: TextStyle(
                                            color: Colors.indigo.shade900),
                                      )
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: bloc.showButtons![index],
                                      builder: (ctx, v, w) {
                                        if (v != null)
                                          return SizedBox(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    bloc.showButtons![index]
                                                        .value =
                                                    !bloc.showButtons![index]
                                                        .value;
                                                  },
                                                  child: SizedBox(
                                                    child: Text(context.locale
                                                        .languageCode ==
                                                        'ru'
                                                        ? snapshot
                                                        .data!.ism![index].descRu
                                                        !.replaceAll(
                                                        '<br>', '\n')
                                                        : snapshot
                                                        .data!.ism![index].descUz
                                                        !.replaceAll(
                                                        '<br>', '\n')),
                                                  ),
                                                ),
                                                BalanceButton(
                                                  title: "buy"
                                                      .tr()
                                                      .toUpperCase(),
                                                  onPressed: () async {
                                                    String urlString =
                                                        'tel:${snapshot.data!
                                                        .ism![index].kod
                                                        !.contains('#',
                                                        snapshot.data!.ism![index]
                                                            .kod!.length - 1)
                                                        ? snapshot.data!
                                                        .ism![index].kod
                                                        : "${snapshot.data!.ism![index].kod}#"}';
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
              );
            }
            else {
              return const SizedBox();
            }
          })
    );
  }
}
