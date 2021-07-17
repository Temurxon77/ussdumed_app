import 'dart:io';

/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uzmobile/bloc/rate_bloc.dart';
import 'package:uzmobile/model/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzmobile/utils/helperFunctions.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final bloc = RateBloc();

  @override
  void initState() {
    bloc.getRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),onPressed: () async => await popPage(context: context)),
          title: Text('rates'.tr()),
        ),
        body: StreamBuilder(
          stream: bloc.rates,
          builder:
              (BuildContext context, AsyncSnapshot<List<Tarifs>> snapshot) {
            if (snapshot.hasData)
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 10,
                    child: PageView.builder(
                        pageSnapping: true,
                        onPageChanged: (index) {
                          bloc.circleColor.value = index;
                        },
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data![0].descrRu);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      // snapshot.data[index].photo != "" &&
                                      //         snapshot.data[index].photo != null
                                      //     ? Image.asset(
                                      //         "assets/icon/${snapshot.data[index].photo}.png")
                                      //     :
                                      const SizedBox(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8, left: 8),
                                        child: Text(
                                          context.locale.languageCode == 'ru'
                                              ? snapshot.data![index].titleRu ?? ""
                                              : snapshot.data![index].titleUz ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22)
                                        )
                                      )
                                    ]
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                        child: Html(
                                      data: snapshot.data![index].descrRu!.replaceAll('ic_sms.png', 'https://i.ibb.co/gZB1fzB/ic-sms.png').replaceAll('ic_phone.png',
                                                        'https://i.ibb.co/c279b5g/ic-phone.png')
                                                    .replaceAll('ic_chart.png',
                                                        'https://i.ibb.co/ZNbmwsK/ic-chart.png')
                                                    .replaceAll('ic_gift.png',
                                                        'https://i.ibb.co/HVWYFHD/ic-gift.png')
                                    )
                                    // WebViewPlus(
                                    //   javascriptMode: JavascriptMode.disabled,
                                    //   debuggingEnabled: false,
                                    //   userAgent: 'Safari iOS 5.1 - iPhone',
                                    //   onWebViewCreated: (c) {
                                    //     print(snapshot.data[index].descrRu);
                                    //
                                    //     String html;
                                    //
                                    //     if (context.locale.languageCode ==
                                    //         'ru') {
                                    //       html = snapshot.data[index].descrRu
                                    //           .replaceAll('ic_sms.png',
                                    //               'https://i.ibb.co/gZB1fzB/ic-sms.png')
                                    //           .replaceAll('ic_phone.png',
                                    //               'https://i.ibb.co/c279b5g/ic-phone.png')
                                    //           .replaceAll('ic_chart.png',
                                    //               'https://i.ibb.co/ZNbmwsK/ic-chart.png')
                                    //           .replaceAll('ic_gift.png',
                                    //               'https://i.ibb.co/HVWYFHD/ic-gift.png');
                                    //     } else {
                                    //       html = snapshot.data[index].descrUz
                                    //           .replaceAll('ic_phone.png',
                                    //               'https://i.ibb.co/c279b5g/ic-phone.png')
                                    //           .replaceAll('ic_sms.png',
                                    //               'https://i.ibb.co/gZB1fzB/ic-sms.png')
                                    //           .replaceAll('ic_chart.png',
                                    //               'https://i.ibb.co/ZNbmwsK/ic-chart.png')
                                    //           .replaceAll('ic_gift.png',
                                    //               'https://i.ibb.co/HVWYFHD/ic-gift.png');
                                    //     }
                                    //     if (Platform.isIOS) {
                                    //       html += """<style>body {zoom: 3;
                                    //       -moz-transform: scale(3);
                                    //       -moz-transform-origin: 0 0;}</style>""";
                                    //     }
                                    // html= html.replaceAll("red", "deepskyblue");
                                    //     c.loadString(html);
                                    //   },
                                    // ),
                                    )
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      String codeNumber = 'tel:${snapshot.data![index].kod}#"}';
                                      if (await canLaunch(codeNumber)) {
                                         await FlutterPhoneDirectCaller.callNumber(codeNumber);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        color: Colors.green,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Text(
                                            "go_over".tr().toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style:  const TextStyle(color: Colors.white),
                                          )
                                        )
                                      )
                                    )
                                  )
                                ]
                              )
                            )
                          );
                        })
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                            valueListenable: bloc.circleColor,
                            builder: (BuildContext context, value, Widget? child) {
                              if (value == index)
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    )
                                  )
                                );
                              else
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    )
                                  )
                                );
                            });
                      }
                    )
                  )
                ]
              );
            else {
              return const SizedBox();
            }
          }
        ));
  }
}
