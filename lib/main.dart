import 'package:flutter/material.dart';
import 'package:searchbyimage_ecom_flutterapp/views/image_search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search by image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageSearch(),
    );
  }
}
