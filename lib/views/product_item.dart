import 'package:flutter/material.dart';
import 'package:searchbyimage_ecom_flutterapp/models/product.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  final Product shoes;
  const ProductItem(this.shoes, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              shoes.picture,
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(shoes.productName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('\$${shoes.price}',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
