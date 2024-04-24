import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:m_project/shop.dart';
import 'package:m_project/singup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class LoginPageExample extends StatefulWidget {
  const LoginPageExample({Key? key}) : super(key: key);

  @override
  State<LoginPageExample> createState() => _LoginPageExampleState();
}

class _LoginPageExampleState extends State<LoginPageExample> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formsKey = GlobalKey<FormState>();

  bool isLoginAPiResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(height: 43.86),
            const Text(
              "Sign In",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Username",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter username",
                  filled: true,
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                ),
                controller: emailController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Please enter email";
                  } else if (!RegExp('[a-zA-Z]').hasMatch(v)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Password",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Form(
              key: formsKey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "•••••••••••",
                  filled: true,
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            isLoginAPiResponse
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () {
                signIn();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                primary: Color(0xFF009CF9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Sign In"),
            ),
            TextButton(
              onPressed: () async {
                UserCredential user = await signInWithGoogle();
                print("user data is -----  ${user.user!.uid}");
                print("user data is -----  ${user.user!.email}");
                print("user data is -----  ${user.user!.displayName}");
                print("user data is -----  ${user.user!.photoURL}");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageExample(),
                    ),
                    (route) => false);
              },
              child: Text("Continue with Google"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatedAccountExample(),
                  ),
                );
              },
              child: Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState!.validate() && formsKey.currentState!.validate()) {
      setState(() {
        isLoginAPiResponse = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        http.Response response = await http.post(
          Uri.parse("https://todo-list-app-kpdw.onrender.com/api/auth/signin"),
          body: {
            "username": emailController.text,
            "password": passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          prefs.setString("token", jsonDecode(response.body)['accessToken']);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successfully")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageExample(),
            ),
                (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)['message'])),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred. Please try again later.")),
        );
      } finally {
        setState(() {
          isLoginAPiResponse = false;
        });
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
       saveUserDataToFirestore(userCredential.user!);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


void saveUserDataToFirestore(User user) {
  FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'photo': user.photoURL,
  });
}
}
