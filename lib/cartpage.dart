import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  var box = Hive.box('cart');
  HomeController controller = Get.put(HomeController());
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    cartItems = getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculation();
    double totalGST = totalPrice * 0.07;
    double totalPriceWithGST = totalPrice + totalGST;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF303030),
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
              ),
              itemCount: cartItems.length,
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
                        "${cartItems[index]['image']}",
                        height: 200,
                      ),
                      Text("${cartItems[index]['name']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Text("${cartItems[index]['distribution']}",
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
                          Text("${cartItems[index]['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (cartItems[index]["qty"] > 1) {
                                  cartItems[index]["qty"]--;
                                  box.put(
                                      cartItems[index]['id'], cartItems[index]);
                                  setState(() {});
                                }
                              },
                              icon: Icon(Icons.remove)),
                          Text(
                            '${cartItems[index]["qty"]}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                              onPressed: () {
                                cartItems[index]["qty"]++;
                                box.put(
                                    cartItems[index]['id'], cartItems[index]);
                                setState(() {});
                              },
                              icon: Icon(Icons.add))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${calculation().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'GST (7%): \$${totalGST.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Total including GST: \$${totalPriceWithGST.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF303030),
        onPressed: () {
          makePayment(totalPriceWithGST);
        },
        tooltip: 'Make Payment',
        child: const Icon(Icons.payment),
      ),
    );
  }

  List<Map<String, dynamic>> getCartItems() {
    List<Map<String, dynamic>> cartItems = [];
    List keyList = box.keys.toList();
    for (var i = 0; i < keyList.length; i++) {
      dynamic item = box.get(keyList[i]);
      if (item is Map<String, dynamic>) {
        Map<String, dynamic> a = Map<String, dynamic>.from(item);
        a.addAll({"id": keyList[i]});
        cartItems.add(a);
      }
    }
    return cartItems;
  }

  double calculation() {
    double totalPrice = 0.0;
    if (cartItems.isNotEmpty) {
      totalPrice = cartItems
          .map((e) => double.parse(e["price"].toString()) * e["qty"]!)
          .toList()
          .reduce((a, b) => a + b);
    }
    return totalPrice;
  }

  Future<void> makePayment(double totalPriceWithGST) async {
    int amountInCents = (totalPriceWithGST * 100).toInt(); // Convert to cents
    try {
      paymentIntentData = await createPaymentIntent(amountInCents, 'INR');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.dark,
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          merchantDisplayName: 'MEMETHOD-FITNESS',
        ),
      );

      // Now finally display payment sheet
      displayPaymentSheet();
    } catch (e, s) {
      print('Exception: $e, StackTrace: $s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        await saveToHistory(paymentIntentData!['id'],
            paymentIntentData!['amount'], DateTime.now());
        print('Payment intent id: ${paymentIntentData!['id']}');
        print('Payment intent amount: ${paymentIntentData!['amount']}');
      });
    } on StripeException catch (e) {
      print('StripeException: $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Payment Cancelled"),
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer YOUR_STRIPE_SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating payment intent: $err');
      rethrow;
    }
  }

  Future<void> saveToHistory(String id, double amount, DateTime date) async {
    try {
      await FirebaseFirestore.instance.collection('history').add({
        'id': id,
        'name': 'Payment',
        'amount': amount,
        'date': date,
      });
    } catch (e) {
      print('Error saving to history: $e');
    }
  }
}
