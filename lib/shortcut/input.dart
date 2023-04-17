import 'package:cumt_login/config.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

// 点击添加按钮调用此函数，弹出输入对话框
void toDialog({
  required BuildContext context,
  required List<Map<String, String>> list,
  required VoidCallback callback,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(
            list: list,
            callback: callback,
            title: "添加自定义网址",
            usage: '添加',
        );
      }
  );
}


// 定义对话框
class InputDialog extends StatefulWidget {
  final List<Map<String, String>> list;
  final VoidCallback callback;
  final String title;
  final String usage;
  final String? initName;
  final String? initUrl;

  const InputDialog({
    Key? key,
    required this.list,
    required this.callback,
    required this.title,
    required this.usage,
    this.initName,
    this.initUrl
  }) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initName ?? "";
    _urlController.text = widget.initUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox)
      ),
      child: Container(
        padding: EdgeInsets.all(UIConfig.paddingAll),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
            border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          width: 2.0
      )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: UIConfig.fontSizeTitle,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(height: 10),
              _buildTextField("标题", _nameController),
              _buildTextField("网址", _urlController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(),
                  _buildExitButton(),
                ],
              ),
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
          Map<String, String> web = {
            "name": _nameController.text.trim(),
            "url" : _urlController.text.trim()
          };
          widget.list.add(web);
          Navigator.of(context).pop();
          showSnackBar(context, "成功${widget.usage} ${_nameController.text}");
          widget.callback();
        }
      },
      child: Text(widget.usage, style: TextStyle(fontSize: UIConfig.fontSizeMain)),
    );
  }

  Widget _buildExitButton() {
    return OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("取消", style: TextStyle(fontSize: UIConfig.fontSizeMain))
    );
  }
}
