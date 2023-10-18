import 'dart:convert';
import 'dart:io';
import 'package:cumt_login/settings/feedback/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../config.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<File> images = [];

  Future<void> addImage(File image) async {
    final bytes = await image.readAsBytes();
    final encodedImage = base64Encode(bytes); // 将字节流编码为base64字符串
    setState(() {
      images.add(image);
      FeedBackPage.imageList.add(encodedImage);
    });
  }

  void removeImageAtIndex(int index) {
    setState(() {
      images.removeAt(index);
      FeedBackPage.imageList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (int i = 0; i < images.length; i++)
          _buildEntry(context, images[i], i),
        ImagePickerButton(
          onImagePicked: (image) {
            addImage(image);
          },
        ),
      ],
    );
  }

  Widget _buildEntry(BuildContext context, File imageFile, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PhotoView(
              imageProvider: FileImage(imageFile),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
          color: Theme.of(context).canvasColor,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: PhotoView(
                imageProvider: FileImage(imageFile),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  removeImageAtIndex(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black.withOpacity(0.5),
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePickerButton extends StatefulWidget {
  final Function(File) onImagePicked;

  const ImagePickerButton({super.key, required this.onImagePicked});

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getImage();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
          color: Theme.of(context).canvasColor,
        ),
        child: const Wrap(
          children: [
            SizedBox(
              width: 37,
              height: 31,
              child: Icon(Icons.photo_camera_back_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
