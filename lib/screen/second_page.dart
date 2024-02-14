import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_task/screen/config/data/Cart.dart';
import 'package:product_task/screen/config/data/product_data.dart';
import 'package:badges/badges.dart' as badges;

import '../provider/multi_Provider.dart';
import 'third_page.dart';
import 'config/data/db_helper.dart';

class Products extends ConsumerWidget {
  int index;

  Products(this.index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DBHelper? db = DBHelper();
    final c = ref.watch(cart);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text("Shopping",style: GoogleFonts.aboreto(fontSize: 25),),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
                child: Center(
                  child: badges.Badge(
                    badgeContent: Text(c.getCounter().toString()),
                    child: Icon(Icons.shopping_bag_outlined),
                  ),
                ),
              ),
              SizedBox(width: 20.0)
            ]),
        body: Card(
          child: Column(
            children: [
              Expanded(child: Center(child: Image.asset(image[index]))),
              Center(
                child: Text(
                  "${name[index]}",
                  style: GoogleFonts.aboreto(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(onTap: () {
                db!
                    .insert(Cart(
                    id: index,
                    productId: index.toString(),
                    productName: name[index].toString(),
                    initialPrice: productPrice[index],
                    productPrice: productPrice[index],
                    quantity: 1,
                    image: image[index].toString()))
                    .then((value) {
                  c.addTotalPrice(
                      double.parse(productPrice[index].toString()));
                  c.addCounter();
                  final snackBar = SnackBar(
                    backgroundColor: Colors.blueGrey,
                    content: Text('Product is added to cart'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
                child: Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text("Add To Cart",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),

              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
