import 'package:flutter/material.dart';
import '../../config.dart';
import 'login_title.dart';

class DividingCpn extends StatelessWidget {

  final String text;

  const DividingCpn({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(UIConfig.paddingHorizontal,
          UIConfig.paddingHorizontal * 2, UIConfig.paddingHorizontal, 0),
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTitle(
            title: text,
          ),
        ],
      ),
    );
  }
}