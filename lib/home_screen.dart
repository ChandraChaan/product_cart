import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.shopping_cart,
                color: Colors.black54,
                size: 30.0,
              ),
            ],
          )),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 80,
                    width: 90,
                    color: Colors.purpleAccent,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Title',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      // SizedBox(width: 55,),
                      Text(
                        'Description',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        'Price',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        'Add To Cart button',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      'Rating',
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
        ),
      ),
    );
  }
}
