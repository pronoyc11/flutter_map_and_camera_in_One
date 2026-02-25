import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectorScreen extends StatefulWidget {
  const ImageSelectorScreen({super.key});

  @override
  State<ImageSelectorScreen> createState() => _ImageSelectorScreenState();
}

class _ImageSelectorScreenState extends State<ImageSelectorScreen> {
  File? imageFile;

  void _showMsg(String msg) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onSelectImage() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      _showMsg("Didn't pick any image!");
      return;
    }

    setState(() {
      imageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid),
            ),
            child: imageFile == null? TextButton.icon(
              onPressed: _onSelectImage,
              label: const Text("Pick an Image"),
              icon: const Icon(Icons.camera),
            ) : GestureDetector(
              onTap: _onSelectImage,
              child: Image(image: FileImage(imageFile!),
              
              width: double.infinity,
              
              ),
            )
          ),
        ],
      ),
    );
  }
}
