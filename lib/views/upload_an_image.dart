import 'package:flutter/material.dart';

class UploadAnImage extends StatelessWidget {
  const UploadAnImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.black26, borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Up load image",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
