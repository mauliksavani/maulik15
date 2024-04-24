import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'loginpage.dart';


class CreatedAccountExample extends StatefulWidget {
  const CreatedAccountExample({Key? key}) : super(key: key);

  @override
  State<CreatedAccountExample> createState() => _CreatedAccountExampleState();
}

class _CreatedAccountExampleState extends State<CreatedAccountExample> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  final formsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formsKey,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 62,
                  left: 25,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 37.55,
                ),
                child: const Text(
                  "user Name",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 4,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "enter name",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please enter name";
                        } else if (!RegExp('[a-zA-Z]').hasMatch(v)) {
                          return "please enter valid name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: usernameController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.45),
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: const Text(
                  "Email Address",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 4,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "enter email",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please enter email";
                        } else if (!RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(v)) {
                          return "please enter valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.45),
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: const Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 4,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "enter password",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please enter password";
                        } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(v)) {
                          return "please enter valid password";
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.45),
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: const Text(
                  "phone",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 4,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "enter phone no",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                      controller: confirmController,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(left: 230, right: 0),
                padding:
                EdgeInsets.only(left: 37, top: 37, bottom: 2, right: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    signup();
                    if (formsKey.currentState!.validate()) {
                      print("-=-==-=-=-  success");
                    } else {
                      print("Submit");
                    }
                  },
                  child: Row(
                    children: [
                      Text("Submit"),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF009CF9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signup() async {
    http.Response response = await http.post(
      Uri.parse("https://todo-list-app-kpdw.onrender.com/api/auth/signup"),
      body: {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmController.text
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonDecode(response.body)['message'])));

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPageExample(),
        ),
            (route) => false,
      );
    }
  }
}