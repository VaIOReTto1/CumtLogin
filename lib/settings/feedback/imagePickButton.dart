import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../config.dart';


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<File> images = [];

  void addImage(File image) {
    setState(() {
      images.add(image);
    });
  }

  void removeImageAtIndex(int index) {
    setState(() {
      images.removeAt(index);
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
            if (imageFile != null)
              SizedBox(
                width: 65,
                height: 65,
                child: PhotoView(
                  imageProvider: FileImage(imageFile),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  loadingBuilder: (context, event) => Center(
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

  ImagePickerButton({required this.onImagePicked});

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
        child: Wrap(
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
