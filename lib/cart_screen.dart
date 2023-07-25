import 'package:flutter/material.dart';
import 'models/product_model.dart';


// Example of using the fetchProducts function in a StatefulWidget
class CartScreen extends StatefulWidget {
  final List<Product> items;

  const CartScreen({super.key, required this.items});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white60,
          title: const Text(
            'Cart',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, color: Colors.black),
          )),
      body: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 140,
              width: double.infinity,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 90,
                          child: Image.network(widget.items[index].thumbnail),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.items[index].title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black),
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
                        '\$${widget.items[index].price.toStringAsFixed(2)}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black),
                      ),

                      // Row(
                      //   children: <Widget>[
                      //     _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
                      //     new Text(_itemCount.toString()),
                      //     new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
                      //   ],
                      // ),


                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.items[index].rating}',
                        style: const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                       const SizedBox(height: 28,),
                       const IconButton(
                        icon: Icon(Icons.delete),color: Colors.black,
                        onPressed: null,
                      ),

                    ],
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
