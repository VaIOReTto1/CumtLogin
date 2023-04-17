import 'package:cumt_login/shortcut/prefs.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../utils/utils.dart';

void toEditing({
  required BuildContext context,
  required List<Map<String, String>> list,
  required VoidCallback callback,
  required String? initName,
  required String? initUrl,
  required int index
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(
          list: list,
          callback: callback,
          title: "编辑自定义网址",
          usage: '提交编辑',
          initName: initName,
          initUrl: initUrl,
          index: index,
        );
      }
  );
}

// 定义编辑对话框
// TODO：大大滴复用，其实只用重写一个函数，之后改一下
class EditDialog extends StatefulWidget {
  final List<Map<String, String>> list;
  final VoidCallback callback;
  final String title;
  final String usage;
  final String? initName;
  final String? initUrl;
  final int index;

  const EditDialog({
    Key? key,
    required this.list,
    required this.callback,
    required this.title,
    required this.usage,
    this.initName,
    this.initUrl,
    required this.index
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
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
                color: Theme.of(context).colorScheme.background,
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
          widget.list[widget.index] = web;
          saveLinks(widget.list);
          // widget.list.add(web);
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
