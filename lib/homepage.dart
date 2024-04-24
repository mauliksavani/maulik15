import 'package:add/shop.dart';
import 'package:flutter/material.dart';

class HomePageExample extends StatefulWidget {
  const HomePageExample({Key? key}) : super(key: key);

  @override
  State<HomePageExample> createState() => _HomePageExampleState();
}

class _HomePageExampleState extends State<HomePageExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset("assets/image/blackw.webp"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Checkout  latest collection  of watches",
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(),));
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepOrange),
              ),
              child: Text(
                'GO',style:TextStyle(fontFamily: "Poppins") ,
              ),
            )
          ],
        ),
      ),
    );
  }
}