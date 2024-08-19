import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/screens/auth/forgot_pw_page.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final user = FirebaseAuth.instance.currentUser;

  void forgotPw() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForgotPwPage();
    }));
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Future verifyEmail() async {
    await user!.sendEmailVerification();

    // Show a dialog to inform the user to check their email
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Verify your email'),
        content: Text(
            'A verification code has been sent to ${user!.email}. Please check your email to verify your account.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor:
                      Colors.white, // <-- Button color // <-- Splash color
                ),
                onPressed: () {},
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 60.0,
                )),
            //EMAIL TEXT
            MyText(
              text: user!.email ?? "missing",
              size: 20,
            ),
            SizedBox(
              height: 20,
            ),

            //VERIFY EMAIL WARNING+BUTTON
            !user!.emailVerified
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.yellow.shade700,
                            size: 20,
                          ),
                          Text(
                            "verify your email!",
                            style: TextStyle(
                                color: Colors.yellow.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      MaterialButton(
                        onPressed: verifyEmail,
                        color: Colors.amber,
                        child: Text(
                          "Verify email",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  )
                : SizedBox.shrink(),
            //FORGOT PW BUTTON
            MaterialButton(
              onPressed: forgotPw,
              color: Colors.amber,
              child: Text(
                "Change password",
                style: TextStyle(color: Colors.black),
              ),
            ),

            //LOGOUT BUTTON
            MaterialButton(
              onPressed: logOut,
              color: Colors.orange,
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
