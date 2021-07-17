import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uzmobile/bloc/service_bloc.dart';
import 'package:uzmobile/model/service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzmobile/utils/helperFunctions.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final bloc = ServiceBloc();

  @override
  void initState() {
    bloc.getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),onPressed: () async => await popPage(context: context)),
        title: Text('services'.tr().toUpperCase())
      ),
      body: StreamBuilder<List<Service>>(
          stream: bloc.services,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    context.locale.languageCode == "ru"
                                        ? snapshot.data![i].titleRu ?? ""
                                        : snapshot.data![i].titleUz ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)
                                  )
                                ),
                                subtitle: Text(
                                    context.locale.languageCode == "ru"
                                        ? snapshot.data![i].descrRu ?? ""
                                        : snapshot.data![i].descrUz ?? ""),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                  child: ClipRect(
                                      clipBehavior: Clip.hardEdge,
                                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                                              child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            snapshot.data![i].codeApply != null
                                                ? FlatButton(
                                                    onPressed: () async {
                                                      if (await canLaunch(snapshot
                                                          .data![i].codeApply ?? "")) {
                                                        if (snapshot
                                                                .data![i].titleRu ==
                                                            "Переадресация вызова")
                                                          await launch(snapshot
                                                              .data![i].codeApply ?? "");
                                                        else
                                                          await FlutterPhoneDirectCaller
                                                              .callNumber(snapshot
                                                                  .data![i]
                                                                  .codeApply ?? "");
                                                      }
                                                    },
                                                    child: Text(
                                                      'confirm'.tr(),
                                                      style: const TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            snapshot.data![i].codeDeny != null
                                                ? FlatButton(
                                                    onPressed: () async {
                                                      if (await canLaunch(snapshot
                                                          .data![i].codeDeny ?? "")) {
                                                        await FlutterPhoneDirectCaller
                                                            .callNumber(snapshot
                                                                .data![i].codeDeny ?? "");
                                                      }
                                                    },
                                                    child: Text(
                                                      'deny'.tr(),
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  )
                                                : const SizedBox(),
                                            snapshot.data![i].codeSet != null
                                                ? FlatButton(
                                                    onPressed: () async {
                                                      if (await canLaunch(snapshot
                                                          .data![i].codeSet ?? "")) {
                                                        await FlutterPhoneDirectCaller
                                                            .callNumber(snapshot
                                                                .data![i].codeSet ?? "");
                                                      }
                                                    },
                                                    child: Text(
                                                      'set'.tr(),
                                                      style: const TextStyle(
                                                          color: Colors.amber)
                                                    )
                                                  )
                                                : const SizedBox()
                                          ]
                                        )
                                      )
                                    ))
                            ])
                      )
                    );
                  });
            else
              return const SizedBox();
          })
    );
  }
}
