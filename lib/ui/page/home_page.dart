/*
    @Authour: Islomkuja Akhrorov
    Created at: 7/13/20
*/
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:launch_review/launch_review.dart';
import 'package:uzmobile/bloc/home_bloc.dart';
import 'package:uzmobile/repository/repository.dart';
import 'package:uzmobile/ui/page/balance_page.dart';
import 'package:uzmobile/ui/page/internet_page.dart';
import 'package:uzmobile/ui/page/minute_sms_page.dart';
import 'package:uzmobile/ui/page/rate_page.dart';
import 'package:uzmobile/ui/page/service_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzmobile/utils/constants.dart';
import 'package:uzmobile/utils/helperFunctions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final bloc = HomeBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final Color? accentColor;
  @override
  void initState() {
    accentColor = colorPalletes[Repository.companyID - 1];
    // bloc.getData().then((value) {
    //   _scaffoldKey.currentState?.showSnackBar(SnackBar(
    //     content: Text(value.tr()),
    //     duration: const Duration(milliseconds: 700)
    //   ));
    // });
    super.initState();
  }

  rateApp() {
    LaunchReview.launch(
        androidAppId: 'uz.uzmobile.helper',
        iOSAppId: '', // Todo:
        writeReview: false);
  }

  share() async {
    if (Platform.isIOS)
      await Share.share(''); // TODO : APP Store link
    else {
      await Share.share(
          'https://play.google.com/store/apps/details?id=uz.uzmobile.helper');
    }
  }

  telegramLaunch() async {
    String telegram = 'https://t.me/USSDMobileUzb';
    if (await canLaunch(telegram)) {
      await launch(telegram);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(),
        bottomNavigationBar: bottomNavigationBar(),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: colorPalletes[Repository.companyID - 1],
          title: Text('uzmobile'.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: telegramLaunch,
            ), IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: rateApp,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: share,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(
                            iconsList[Repository.companyID - 1],
                            scale: 20
                          )),
                      const SizedBox(
                        width: 10
                      ),
                      Text(
                        'national_operator'.tr(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  )),
              Expanded(
                child: GridView.count(
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30
                    ),
                    crossAxisCount: 2,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlatButton(
                            onPressed: () async => await navigateTo(context: context,child: BalancePage()),
                            child: Card(
                              color: accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: Image.asset(
                                'assets/icon/balans.png',
                                color: Colors.white,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text('balance'.tr().toUpperCase())
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () async => await navigateTo(context: context,child: InternetPage()),
                            child: Card(
                              color: accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: Image.asset(
                                'assets/icon/internet.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text('internet'.tr().toUpperCase())
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () async => await navigateTo(context: context,child: RatePage()),
                            child: Card(
                              color: accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: Image.asset(
                                'assets/icon/tarifi.png',
                                color: Colors.white
                              )
                            )
                          ),
                          Text('rates'.tr().toUpperCase())
                        ]
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () async => await navigateTo(context: context,child: ServicePage()),
                            child: Card(
                                color: accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 3,
                                child: Image.asset(
                                    'assets/icon/uslugi.png',
                                    color: Colors.white
                                )
                            )
                          ),
                          Text('services'.tr().toUpperCase())
                        ]
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () async => await navigateTo(context: context,child: MinuteSmsPage()),
                            child: Card(
                              color: accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: Image.asset(
                                'assets/icon/minuti.png',
                                color: Colors.white
                              )
                            )
                          ),
                          Text('minute_sms'.tr().toUpperCase())
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () async {
                              if(await canLaunch("http://google.uz")) {
                                launch("https://uztelecom.uz/${context.locale.languageCode}/jismoniy-shaxslarga/mobil-aloqa/gsm-2/chiroyli-raqamlar");
                              }
                            },
                            child: Card(
                              color: accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              child: Image.asset(
                                'assets/icon/news.png',
                                color: Colors.white
                              )
                            )
                          ),
                          Text('numbers'.tr().toUpperCase())
                        ]
                      )
                    ])
              )
            ]
          )
        ));
  }

  Widget bottomNavigationBar() {
    final Color? accentColor = colorPalletes[Repository.companyID - 1];
    return BottomNavigationBar(
      enableFeedback: false,
      selectedIconTheme: IconThemeData(color: accentColor),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.call),
            label: 'call_center'.tr().toUpperCase()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: 'home'.tr().toUpperCase()),
        BottomNavigationBarItem(
          icon: const Icon(Icons.sim_card),
          label: 'cabinet'.tr().toUpperCase(),
        ),
      ],
      currentIndex: 1,
      onTap: (index) async {
        if (index == 0) {
          String codeNumber = 'tel:1099';
          if (await canLaunch(codeNumber)) {
            await FlutterPhoneDirectCaller.callNumber(codeNumber);
          }
        }
        if (index == 2) {
          String urlString = "https://cabinet.uztelecom.uz/ps/scc/login.php";
          if (await canLaunch(urlString)) await launch(urlString);
        }
      },
      selectedItemColor: accentColor,
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "more".tr(),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[700]),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('russian'.tr()),
            onTap: () {
              context.locale = Locale('ru', 'RU');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('uzbek'.tr()),
            onTap: () {
              context.locale = Locale('uz', 'UZ');
              Navigator.pop(context);
            }
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text('share'.tr()),
            onTap: share
          ),
          ListTile(
            leading: const Icon(Icons.send),
            title: Text('telegram_channel'.tr()),
            onTap: telegramLaunch
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text('rate_app'.tr()),
            onTap: rateApp
          )
        ]
      )
    );
  }
}
