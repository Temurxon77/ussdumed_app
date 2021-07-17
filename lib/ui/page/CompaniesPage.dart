import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart';

import 'package:uzmobile/bloc/home_bloc.dart';
import 'package:uzmobile/repository/repository.dart';
import 'package:uzmobile/ui/page/home_page.dart';
import 'package:uzmobile/utils/constants.dart';

class CompaniesPage extends StatelessWidget {

  CompaniesPage() {
    init();
  }

  final HomeBloc bloc = HomeBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> init() async {
    bloc.getData().then((value) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(value.tr()),
        duration: const Duration(milliseconds: 700)
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Image.asset("assets/images/uztelecom.png",fit: BoxFit.fitWidth,height: 100.0,)
        ),
        Expanded(
          flex: 1,
          child: Card(child: SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: InkWell(
              onTap: () async {
                Repository.companyID = 1;
                await Navigator.push(context, CupertinoPageRoute(
                    builder: (BuildContext context) => HomePage()
                ));
              },
              child: Image.asset(logosImg[0],fit: BoxFit.contain,height: 100.0))),elevation: 2
        )),
        Expanded(
          flex: 1,
          child: Card(child: SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: InkWell(
              onTap: () async {
                Repository.companyID = 2;
                await Navigator.push(context, CupertinoPageRoute(
                    builder: (BuildContext context) => HomePage()
                ));
              },
              child:  Image.asset(logosImg[1],fit: BoxFit.scaleDown,height: 100.0))),elevation: 2
        )),
        Expanded(
          flex: 1,
          child: Card(child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: InkWell(
                onTap: () async {
                  Repository.companyID = 3;
                  await Navigator.push(context, CupertinoPageRoute(
                      builder: (BuildContext context) => HomePage()
                  ));
                },
                child: Image.asset(logosImg[2],fit: BoxFit.contain,height: 100.0))),elevation: 2
        )),
        Expanded(
          flex: 1,
          child:  Card(child: SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              child: InkWell(
                  onTap: () async {
                    Repository.companyID = 4;
                    await Navigator.push(context, CupertinoPageRoute(
                        builder: (BuildContext context) => HomePage()
                    ));
                  },
                  child: Image.asset(logosImg[3],fit: BoxFit.contain,height: 100.0))
        ),elevation: 2))
      ]
    )
    );
  }
}