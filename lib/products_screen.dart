import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart_screen.dart';
import 'models/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];
  List<Product> cartProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  Future<List<Product>> fetchProducts() async {
    const String url = 'https://dummyjson.com/products';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];

      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'E-Commerce App',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                height: 35,
                width: 50,
                color: Colors.white24,
                child: const Icon(
                  Icons.dehaze_rounded,
                  color: Colors.black45,
                  size: 34.0,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen(items: cartProducts,)),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black54,
                    size: 30.0,
                  )),
            ],
          )),
      body: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 140,
              width: double.infinity,
              color: Colors.black12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 80,
                      width: 90,
                      child: Image.network(products[index].thumbnail),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].title,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      // SizedBox(width: 55,),
                      const Text(
                        'des',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${products[index].price.toStringAsFixed(2)}',
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey.shade900),
                          onPressed: cartProducts.any((Product element) =>
                                  element == products[index])
                              ? null
                              : () {
                                  cartProducts.add(products[index]);
                                },
                          child: const Text('Add to Cart')),
                    ],
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '${products[index].rating}',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
