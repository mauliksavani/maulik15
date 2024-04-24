import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addWatch.dart';
import 'cartpage.dart';





class WomenWatch extends StatefulWidget {
  const WomenWatch({super.key});

  @override
  State<WomenWatch> createState() => _WomenWatchState();
}

class _WomenWatchState extends State<WomenWatch> {
  List<Map<String, dynamic>> items = [
    {
      "image": "https://5.imimg.com/data5/SELLER/Default/2022/9/UB/DU/MC/156795250/rolex-diamond-watch-for-ladies-500x500.jpeg",
      "name" : "Isabella",
      "distribution":"Moonwatch Professional Co‑Axial",
      "price":"9",
    },
    {
      "image": "https://kdbdeals.com/wp-content/uploads/2023/08/Rolex-Luxurious-Watch-For-Women-1.jpg",
      "name":"Rolex",
      "distribution" :"Master Chronometer Chronograph",
      "price":"39",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnXdMbrSOVPrOWdxS7j65AYYc8MC-s3Z-RbD0NwQBxKg&s",
      "name":"Arabella",
      "distribution" :"Master Chronometer Chronograph",
      "price":"7",
    },
    {
      "image": "https://img.joomcdn.net/eb8bee84092e46d28ed1a1bd99f0a28e047f5bf6_original.jpeg",
      "name":"Poedagar",
      "distribution" :"Master Chronometer Chronograph",
      "price":"12",
    },
    {
      "image": "https://img.joomcdn.net/25b678cddd41f302cbd994dac3e65f3a3578f8ce_400_400.jpeg",
      "name":"Valentina",
      "distribution" :"Master Chronometer Chronograph",
      "price":"11",
    },
    {
      "image": "https://img.joomcdn.net/6d03a3cbf7ee69f2558fa909b293f18b2f9c0eb7_1024_1024.jpeg",
      "name":"Allegra",
      "distribution" :"Master Chronometer Chronograph",
      "price":"59",
    },
    {
      "image": "https://img.joomcdn.net/46d493be7d67214116013116316ae76da2517ec2_400_400.jpeg",
      "name":"Ophelia",
      "distribution" :"Master Chronometer Chronograph",
      "price":"9",
    },
    {
      "image":"https://img.joomcdn.net/3fb008ddb3b348a81ff00b8f9cae1087eb156d96_original.jpeg",
      "name":"Vivienne",
      "distribution" :"Master Chronometer Chronograph",
      "price":"14",
    },
  ];

  List<Map<String, dynamic>> selectedItems = [];
  var box = Hive.box('cart');

  void saveToCart(Map<String, dynamic> item) {
    Map<String, dynamic> a = item;
    a.addAll({"qty": 1});
    box.add(item);
  }

  List<Map<String, dynamic>> getCartItems() {
    List<Map<String, dynamic>> cartItems = [];
    for (var i = 0; i < box.length; i++) {
      cartItems.add(Map<String, dynamic>.from(box.getAt(i)!));
    }
    return cartItems;
  }

  void URI() {
    launchUrl(Uri.parse("tel:6354646775"),
        mode: LaunchMode.externalApplication);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    selectedItems = getCartItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xFF92715d),
      appBar: AppBar(
        backgroundColor: Color(0xFF303030),
        title: Text("Women's Watch",style:TextStyle(fontFamily: "Poppins") ,),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProduct(),
                    ));
              },
              icon: Icon(Icons.history)),
          IconButton(
              onPressed: () {
                URI();
              },
              icon: Icon(Icons.call)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 30,right: 10),
            child: Text(
              "Welcome to the World of Laxarious watch",
              style: TextStyle(
                  fontSize: 38, color: Color(0xFFFFFFFF), fontFamily: "Poppins"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40,right: 200),
            child: Text(
              "Best Seller",
              style: TextStyle(
                  fontSize: 20, color: Color(0xFFFFFFFF), fontFamily: "Poppins"),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: 3
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 350),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFF646464)),
                  margin: EdgeInsets.only(top: 20,bottom: 0, left: 20),
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "${items[index]['image']}",
                        height: 200,
                      ),
                      Text("${items[index]['name']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      SizedBox(height: 5,),
                      Text("${items[index]['distribution']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.white,
                          ),
                          Text("${items[index]['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (!selectedItems.contains(items[index])) {
                                  selectedItems.add(items[index]);
                                  saveToCart(items[index]);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF303030),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('ADD CART'),
                          ),
                          IconButton(onPressed: (){

                          }, icon: Icon(Icons.share))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF646464),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
