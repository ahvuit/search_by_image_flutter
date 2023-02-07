import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchbyimage_ecom_flutterapp/dummy_data.dart';
import 'package:searchbyimage_ecom_flutterapp/generated/assets.dart';
import 'package:searchbyimage_ecom_flutterapp/models/product.dart';
import 'package:searchbyimage_ecom_flutterapp/views/camera_image_buton.dart';
import 'package:searchbyimage_ecom_flutterapp/views/image_path.dart';
import 'package:searchbyimage_ecom_flutterapp/views/product_item.dart';
import 'package:searchbyimage_ecom_flutterapp/views/upload_an_image.dart';
import 'package:tflite/tflite.dart';

class ImageSearch extends StatefulWidget {
  const ImageSearch({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UIState createState() => _UIState();
}

class _UIState extends State<ImageSearch> {
  List? _outputs;
  XFile? _image;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: Assets.tfliteModelUnquant,
        labels: Assets.tfliteLabels,
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future getImageCamera() async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  Future getImageGallery() async {
    var image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  Product? getProductSearch(String productName) {
    for (var element in productList) {
      if (productName
          .toLowerCase()
          .contains(element.productName.toLowerCase())) {
        return element;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Search Image",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.blueAccent.withOpacity(0.25),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: _image == null
                  ? const UploadAnImage()
                  : Column(
                      children: [
                        ImagePath(_outputs, _image),
                        const SizedBox(height: 20),
                        getProductSearch(_outputs?[0]["label"] ?? "") != null && _outputs?[0]["confidence"] > (0.7)
                            ? Column(
                                children: <Widget>[
                                  const Text("product are available in store",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  ProductItem(
                                      getProductSearch(_outputs?[0]["label"])!),
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("product not available in store",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                      ],
                    ),
            ),
            CameraImageButton(
                getImageCamera: getImageCamera,
                getImageGallery: getImageGallery)
          ],
        ),
      ),
    );
  }
}
