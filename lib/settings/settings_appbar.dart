import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import 'drawer_button.dart';

class SettingsAppBar extends StatelessWidget {
  String title;

  SettingsAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.119,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness != Brightness.dark
                ? const Color.fromRGBO(59, 114, 217, 0.2)
                : Colors.black38,
            spreadRadius: 12,
            blurRadius: 18,
            offset: Offset.zero, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: UIConfig.fontSizeSubTitle * 2,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : const Color.fromRGBO(59, 114, 217, 1),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2),
                  textAlign: TextAlign.center,
                ),
              ),
              HelpButton(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0105,
          )
        ],
      ),
    );
  }
}
