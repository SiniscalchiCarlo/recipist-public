import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/screens/auth/auth_page.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';

class ForgotPwPage extends StatefulWidget {
  const ForgotPwPage({super.key});

  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  final TextEditingController _emailController = TextEditingController();
  String error = "";
  Future pwReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AuthPage();
                    }));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message.toString();
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Enter your email, we will send you a reset password link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          //EMAIL FIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Email"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: error != ""
                  ? Text(error,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold))
                  : SizedBox.shrink()),
          SizedBox(
            height: 10,
          ),
          //SEND BUTTON
          MaterialButton(
            onPressed: pwReset,
            color: Colors.amber,
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
