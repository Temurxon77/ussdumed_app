/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:flutter/material.dart';

class BalanceButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  const BalanceButton({Key? key, @required this.title, this.onPressed})
      : super(key: key);
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          margin: const EdgeInsets.only(top: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white
              )
            )
          ),
          color: Theme.of(context).primaryColor
        )
      )
    );
  }
}
