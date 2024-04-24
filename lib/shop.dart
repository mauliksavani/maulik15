import 'package:flutter/material.dart';
import 'package:m_project/womenw.dart';

import 'manwatch.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF92715d),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Column(
              children: [
                Center(
                  child: Text(
                    "What are you \nshopping for?",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 50),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ManWatchExample(title: '',),));
                  },
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFF646464)
                    ),
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.asset(
                          "assets/image/imageww.jpeg", height: 120,)),
                        SizedBox(height: 10),
                        Text(
                          "Men's", style: TextStyle(fontSize: 30, color: Color(
                            0xFFFFFFFF), fontFamily: "Poppins"),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WomenWatch(),));
                  },
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFF646464)
                    ),
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.asset(
                          "assets/image/tt.jpg", height: 120,)),
                        SizedBox(height: 10),
                        Text("women's", style: TextStyle(fontSize: 30,
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
