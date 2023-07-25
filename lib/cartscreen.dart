import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

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
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [];
  int _itemCount = 0;
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  // Function to delete an item from the list
  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }




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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Text(
            'Cart',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, color: Colors.black),
          )),
      body: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network(products[index].thumbnail),
                          height: 80,
                          width: 90,
                        ),
                      ],
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

                        Row(
                          children: <Widget>[
                            _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
                            new Text(_itemCount.toString()),
                            new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
                          ],
                        ),


                      ],
                    ),
                  ),
                  Container(
                    child:  Column(
                      children: [
                        Text(
                          '${products[index].rating}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                         SizedBox(height: 28,),
                         IconButton(
                          icon: Icon(Icons.delete),color: Colors.black,
                          onPressed: () => deleteItem(index),
                        ),

                      ],
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
}
