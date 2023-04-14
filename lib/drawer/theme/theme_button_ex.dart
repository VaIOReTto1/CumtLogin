import 'package:cumt_login/drawer/theme/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeColorButton extends StatefulWidget {
  final ThemeData themeData;
  final IconData icon;
  final Color color;
  const ThemeColorButton({Key? key, required this.themeData, required this.icon, required this.color}) : super(key: key);

  @override
  State<ThemeColorButton> createState() => _ThemeColorButtonState();
}

class _ThemeColorButtonState extends State<ThemeColorButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {Provider.of<ThemeProvider>(context, listen: false)
          .setThemeData(widget.themeData);
      },
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 30,
            color: widget.color,
          ),
        ],
      ),
    );
  }
}
