import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:url_launcher/url_launcher.dart';

import 'addWatch.dart';
import 'cartpage.dart';

class ManWatchExample extends StatefulWidget {
  const ManWatchExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ManWatchExampleState createState() => _ManWatchExampleState();
}

class _ManWatchExampleState extends State<ManWatchExample> {
  List<Map<String, dynamic>> items = [
    {
      "image":
      "https://st.depositphotos.com/1566632/1403/i/450/depositphotos_14039977-stock-photo-mens-luxury-wrist-watch-on.jpg",
      "name": "Well Dressed ",
      "distribution": "Moonwatch Professional Co‑Axial",
      "price": "99",
    },
    {
      "image":
      "https://i.pinimg.com/736x/12/4e/34/124e34ef3331f50e18ea162a1cd0a696.jpg",
      "name": "Regalia",
      "distribution": "Master Chronometer Chronograph",
      "price": "39",
    },
    {
      "image":
      "https://img.freepik.com/premium-photo/luxury-watches-isolated-white-background-with-clipping-path-gold-watch-women-man-watches-female-male-watches_262663-702.jpg",
      "name": "Prestige Chronographs",
      "distribution": "Master Chronometer Chronograph",
      "price": "50",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFLXi-wwPtCvTy7ZaL-Azgqy-39qWbD_mGPSJhA5UUoA&s",
      "name": "Luxe Legacy",
      "distribution": "Master Chronometer Chronograph",
      "price": "26",
    },
    {
      "image":
      "https://img.freepik.com/premium-photo/luxury-watches-isolated-white-background-with-clipping-path-gold-watch-women-man-watches-female-male-watches_262663-680.jpg",
      "name": "Regalia",
      "distribution": "Master Chronometer Chronograph",
      "price": "199",
    },
    {
      "image":
      "https://img.freepik.com/premium-photo/luxury-watches-isolated-white-background-with-clipping-path-gold-watch-women-man-watches-female-male-watches_262663-691.jpg",
      "name": "Opulent Epochs",
      "distribution": "Master Chronometer Chronograph",
      "price": "105",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPDncqg81urGqWFPUOiJXlpKFE_uiqapbrvbgg5vilIw&s",
      "name": "Sovereign Chronometers",
      "distribution": "Master Chronometer Chronograph",
      "price": "99",
    },
    {
      "image":
      "https://i0.wp.com/poedagar.store/wp-content/uploads/2023/10/POEDAGAR-Luxury-Man-Wristwatch-Sports-Leather-Men-Quartz-Watch-Waterproof-Luminous-Calendar-Chronograph-Men-s-Watches.jpg?fit=1566%2C1566&ssl=1",
      "name": "Celestial Horology",
      "distribution": "Master Chronometer Chronograph",
      "price": "299",
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
        title: Text(
          "Man's Watch",
          style: TextStyle(fontFamily: "Poppins"),
        ),
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
            padding: const EdgeInsets.only(top: 40, left: 30, right: 10),
            child: Text(
              "Welcome to the World of Laxarious watch",
              style: TextStyle(
                  fontSize: 38,
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Poppins"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 200),
            child: Text(
              "Best Seller",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Poppins"),
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
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
                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
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
// class MExample extends StatefulWidget {
//   const MExample({Key? key}) : super(key: key);
//
//   @override
//   State<MExample> createState() => _MExampleState();
// }
//
// class _MExampleState extends State<MExample> {
//   List<Map<String, dynamic>> selectedItems = [];
//   var box = Hive.box('cart');
//
//   void saveToCart(Map<String, dynamic> item) {
//     Map<String, dynamic> a = item;
//     a.addAll({"qty": 1});
//     box.add(item);
//   }
//
//   List<Map<String, dynamic>> getCartItems() {
//     List<Map<String, dynamic>> cartItems = [];
//     for (var i = 0; i < box.length; i++) {
//       cartItems.add(Map<String, dynamic>.from(box.getAt(i)!));
//     }
//     return cartItems;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     selectedItems = getCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase Example"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 40, left: 30, right: 10),
//             child: Text(
//               "Welcome to the World of Laxarious watch",
//               style: TextStyle(
//                 fontSize: 38,
//                 color: Color(0xFFFFFFFF),
//                 fontFamily: "Poppins",
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40, right: 200),
//             child: Text(
//               "Best Seller",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFFFFFFFF),
//                 fontFamily: "Poppins",
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('Amazon').snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Something went wrong: ${snapshot.error}');
//                 }
//
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text("Loading...");
//                 }
//
//                 if (snapshot.data!.docs.isEmpty) {
//                   return Text("No data available");
//                 }
//
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     mainAxisExtent: 350,
//                   ),
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     DocumentSnapshot document = snapshot.data!.docs[index];
//                     Map<String, dynamic> data =
//                         document.data()! as Map<String, dynamic>;
//                     return Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           color: Color(0xFF646464)),
//                       margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
//                       padding: EdgeInsets.only(top: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.network(
//                             data['image'].toString(),
//                             height: 170,
//                             width: 300,
//                           ),
//                           Text(data['Product_name'].toString(),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 20)),
//                           Text(data['Product_description'].toString(),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 20)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.monetization_on_outlined,
//                                 color: Colors.white,
//                               ),
//                               Text(data['Product_price'].toString(),
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 20)),
//                               SizedBox(width: 15),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (!selectedItems.contains(data)) {
//                                       selectedItems.add(data);
//                                       saveToCart(data);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFF303030),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: Text('ADD TO CART'),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => AddProduct(
//                                         userData: data,
//                                         documentId: document.id,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 icon: Icon(Icons.edit),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   _deleteProduct(document.id);
//                                 },
//                                 icon: Icon(Icons.delete_outline),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddProduct(),
//                 ),
//               );
//             },
//             child: Text("Add Product"),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xFF646464),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CartPage()),
//           );
//         },
//         child: Icon(Icons.shopping_cart),
//       ),
//     );
//   }
//
//   // Function to delete product
//   Future<void> _deleteProduct(String documentId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Amazon')
//           .doc(documentId)
//           .delete();
//       print('Product deleted successfully');
//     } catch (error) {
//       print('Error deleting product: $error');
//       // Handle error - show dialog, toast, etc.
//     }
//   }
// }

