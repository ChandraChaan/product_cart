import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartscreen.dart';

// Create a model class to represent the Product data
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}

// Function to fetch data from the API and return a List of Products
Future<List<Product>> fetchProducts() async {
  final String url =
      'https://dummyjson.com/products'; // Replace with your API endpoint

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> productsJson = data['products'];

    return productsJson.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

// Example of using the fetchProducts function in a StatefulWidget
class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var favorateData;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'E-Commerce App',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 35,
                width: 50,
                color: Colors.white24,
                child: Icon(
                  Icons.dehaze_rounded,
                  color: Colors.black45,
                  size: 34.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
              GestureDetector(onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CartScreen()),
                );

              },
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black54,
                  size: 30.0,
                ),

              ),
            ],
          )),
      body: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Image.network(products[index].thumbnail),
                      height: 80,
                      width: 90,
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${products[index].title}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        // SizedBox(width: 55,),
                         Text(
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
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.shade900),
                            onPressed: () {
                            },
                            child: const Text('Add to Cart')),

                      ],
                    ),
                  ),
                  SizedBox(width: 6,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      child:  Text(
                        '${products[index].rating}',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              height: 140,
              width: double.infinity,
              color: Colors.black12,
            ),
          );
        },
      ),
    );
  }

  favorate({required listDat}) {}
}
