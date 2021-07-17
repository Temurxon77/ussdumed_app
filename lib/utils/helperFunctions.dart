import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

Future<void> navigateTo({@required BuildContext? context,@required Widget? child}) async {
  try{
    Navigator.push(
        context!,
        CupertinoPageRoute(
            builder: (BuildContext context) =>
                child!)).then((value) => print("Success....")).catchError((err)=> throw FlutterError("Cannot push child..."));
  }catch(err){
    print(err);
  }
}
Future<void> popPage({@required BuildContext? context}) async {
  try{
    if(Navigator.canPop(context!)) {
      Navigator.pop(context);
    } else {
      throw FlutterError("Cannot pop child...");
    }
  }catch(err){
    print(err);
  }
}