import 'package:flutter/material.dart';


class FeedbackForm extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '请填写您的反馈意见,这对我们非常重要。（也可留下联系方式，方便我们联系您）',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _textEditingController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  String feedback = _textEditingController.text;
                  await cumt.dio.post("", data: {'data': feedback,});
                  _textEditingController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('发送'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}