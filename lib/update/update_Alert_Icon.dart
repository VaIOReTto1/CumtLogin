import 'package:flutter/material.dart';

import '../config.dart';

class UpdateAlertIcon extends StatelessWidget {
  const UpdateAlertIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: UIConfig .fontSizeMain * 0.04, horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: Icon(Icons.keyboard_arrow_up_sharp, color: Colors.red.shade700),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Text(
            '有新版',
            style: TextStyle(fontSize: UIConfig .fontSizeMain * 1.2, color: Colors.red.shade700),
          ),
        ),
      ],
    );
  }
}