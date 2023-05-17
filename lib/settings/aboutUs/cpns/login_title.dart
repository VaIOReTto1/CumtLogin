import 'package:flutter/material.dart';

import 'package:cumt_login/settings/aboutUs/cpns/single_info_card.dart';
import '../../../config.dart';



class LoginTitle extends StatelessWidget {
  final String title;
  final Color textColor;
  const LoginTitle({
    super.key,
    required this.title,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: UIConfig.fontSizeMid / 4,
          width: MediaQuery.of(context).size.width * .3,
          decoration: BoxDecoration(
              color: const Color(0xFF33CC99).withAlpha(255),
              borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox)),
        ),
        SizedBox(
          width: UIConfig.marginVertical * 4,
        ),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : textColor,
            fontSize: UIConfig.fontSizeMain * 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: UIConfig.marginVertical * 4,
        ),
        Container(
          height: UIConfig.fontSizeMid / 4,
          width: MediaQuery.of(context).size.width * .3,
          decoration: BoxDecoration(
              color: loginColorGreen1,
              borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox)),
        ),
      ],
    );
  }
}