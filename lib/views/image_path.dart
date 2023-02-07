import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImagePath extends StatelessWidget {
  final List? _outputs;
  final XFile? _image;
  const ImagePath(this._outputs, this._image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: FileImage(File(_image!.path)), fit: BoxFit.cover),
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(30),
          child: Text(
            _outputs?[0]["confidence"] > (0.7)
                ? "${_outputs?[0]["label"]}\nConfidence: ${_outputs?[0]["confidence"]}"
                : "The product is not recognized",
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
