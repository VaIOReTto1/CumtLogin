import 'package:cumt_login/config.dart';
import 'package:cumt_login/shortcut/ui.dart';
import 'package:flutter/material.dart';

// 点击添加按钮调用此函数，弹出输入对话框
void toDialog({
  required BuildContext context,
  required List<Map<String, String>> list,
  required VoidCallback callback,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(list: list, callback: callback);
      }
  );
}


// 定义对话框
class InputDialog extends StatefulWidget {
  InputDialog({
    Key? key,
    required this.list,
    required this.callback
  }) : super(key: key);
  List<Map<String, String>> list;
  VoidCallback callback;

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
      ),
      child: Container(
        padding: EdgeInsets.all(UIConfig.paddingAll),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary == Colors.blue
                    ? const Color.fromRGBO(230, 231, 233, 1)
                    : Theme.of(context).colorScheme.primary,
                width: 2.0
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                  "添加自定义网址",
                  style: TextStyle(
                      fontSize: UIConfig.fontSizeTitle,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(height: 10),
              _buildTextField("标题", _nameController),
              _buildTextField("网址", _urlController),
              _buildButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildTextField(
      String labelText, TextEditingController textEditingController,
      {obscureText = false, showPopButton = false}) {
    return Container(
      margin: EdgeInsets.all(UIConfig.marginAll),
      padding: EdgeInsets.all(UIConfig.paddingAll),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        if(_nameController.text.isEmpty) {
          showSnackBar(context, "网址标题不能为空");
        } else {
          widget.list.add(
              {
                "name": _nameController.text.trim(),
                "url" : _urlController.text.trim()
              }
          );
          Navigator.of(context).pop();
          showSnackBar(context, "成功添加 ${_nameController.text}");
          widget.callback();
        }
      },
      child: Text('添加', style: TextStyle(fontSize: UIConfig.fontSizeMain)),
    );
  }
}
