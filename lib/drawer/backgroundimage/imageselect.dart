import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


// 很简单的使用方法，用ImageSelect个ImageDelete去选择图片和删除选中图片的文件路径，使用的BackGroundImage同时呈现出你所选择的图片
// ImageSelect和ImageDelete返回的是一个Inkwell，它有一个必填参数child，填入你想要的ui
// BackGroundImage返回的是一个Image，你可以把这个放在任何位置，背景图片的话就用Stack嵌套一下主页面，把BackGroundImage放在底层

// 在配置上的改动：
// 1.在安卓的android/app/src/main/AndroidManifest.xml里添加了如下代码
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
// 用于获取用户的本地存储权限
// 2.在依赖文件里添加了 image_picker: ^0.8.7+1 # 图片选择，用于访问本地相册

//已经在实机上测试了这个功能，可以使用。

class F {
  static Function? _updateCallback;
  static Function? _deleteCallback;

  static void registerUpdateCallback(Function callback) {
    _updateCallback = callback;
  }
  static void registerDeleteCallback(Function callback){
    _deleteCallback = callback;
  }
  static void unregisterUpdateCallback() {
    _updateCallback = null;
  }
  static void unregisterDeleteCallback() {
    _deleteCallback = null;
  }

  static Future<String?> _getImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath');
  }

  static Future<void> _saveImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', path);
    if (_updateCallback != null) {
      _updateCallback!();
    }
  }

  static Future<void> _removeImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagePath');
    if(_deleteCallback!=null){
      _deleteCallback!();
    }
  }

}


class BackGroundImage extends StatefulWidget {
  static String? selectedImage = null;
  const BackGroundImage({Key? key}) : super(key: key);

  @override
  _BackGroundImageState createState() => _BackGroundImageState();
}

class _BackGroundImageState extends State<BackGroundImage> {

  @override
  void initState() {
    super.initState();
    F.registerUpdateCallback(() {
      _updateSelectedImage();
    });
    F.registerDeleteCallback((){
      _deleteSelectedImage();
    });
    _updateSelectedImage();
  }

  @override
  void dispose() {
    F.unregisterUpdateCallback();
    F.unregisterDeleteCallback();
    super.dispose();
  }

  Future<void> _updateSelectedImage() async {
    final String? imagePath = await F._getImagePath();
    setState(() {
      BackGroundImage.selectedImage = imagePath;
    });
  }

  Future<void> _deleteSelectedImage() async {
    setState(() {
      BackGroundImage.selectedImage = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BackGroundImage.selectedImage != null
        ? Image.file(
      File(BackGroundImage.selectedImage!),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    )
        : Scaffold(
    );
  }
}

class ImageSelect extends StatefulWidget {
  final Widget child;
  const ImageSelect({Key? key, required this.child}) : super(key: key);
  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await F._saveImagePath(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _getImageFromGallery();
      },
      child: widget.child,
    );
  }
}

class ImageDelete extends StatefulWidget {
  final Widget child;
  const ImageDelete({Key? key,required this.child}) : super(key: key);

  @override
  State<ImageDelete> createState() => _ImageDeleteState();
}

class _ImageDeleteState extends State<ImageDelete> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        F._removeImagePath();
      },
      child: widget.child,
    );
  }
}


class GlassMorphism extends StatefulWidget {
  double blur = BackGroundImage.selectedImage != null && BackGroundImage.selectedImage!.isNotEmpty ? 0.5 : 0;
  final double opacity = BackGroundImage.selectedImage != null && BackGroundImage.selectedImage!.isNotEmpty ? 0.5 :0;
  final Widget child;
  GlassMorphism({Key? key,required this.child,}) : super(key: key);

  @override
  State<GlassMorphism> createState() => _GlassMorphismState();
}

class _GlassMorphismState extends State<GlassMorphism> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur,sigmaY: widget.blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(widget.opacity),
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}