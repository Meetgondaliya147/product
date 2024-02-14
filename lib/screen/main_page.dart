import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_task/screen/config/data/product_data.dart';
import 'package:product_task/screen/second_page.dart';
import 'package:badges/badges.dart' as badges;
import '../provider/multi_Provider.dart';
import 'third_page.dart';

class Main_screen extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(cart);
    // TODO: implement build
   return SafeArea(
     child: Scaffold(
       backgroundColor: Colors.grey.shade100,
       appBar: AppBar(
         backgroundColor: Colors.grey,
           centerTitle: true,
           title: Text("Products", style: GoogleFonts.aboreto(fontSize: 25)),actions: [
         InkWell(onTap: () {
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
       ]
       ),
       body: GridView.builder(
         itemCount: name.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
         itemBuilder: (context, index) {
           return InkWell(
             onTap: () {
               Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => Products(index),
                   ));
             },
             child: Card(
               child: Column(
                 children: [
                   Expanded(child: Image.asset(image[index])),
                   SizedBox(height: 10,),
                   Text("${name[index]}",maxLines: 1,style: GoogleFonts.aboreto(fontSize: 20)),
                   SizedBox(height: 5,),
                 ],
               ),
             ),
           );
         },
       ),
     ),
   );
  }

}
