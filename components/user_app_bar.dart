import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/screens/auth/auth_page.dart';
import 'package:smart_shopping_list/screens/auth/login_page.dart';
import 'package:smart_shopping_list/screens/auth/profile_info.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class UserAppBar extends StatefulWidget {
  const UserAppBar({super.key});

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  void openProfileInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfileInfo();
    }));
  }

  void openLoginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AuthPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          return Row(
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    backgroundColor:
                        Colors.white, // <-- Button color // <-- Splash color
                  ),
                  onPressed: openProfileInfo,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30.0,
                  )),
              //EMAIL AND WARNINGS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //EMAIL
                  MyText(
                    text: user!.email!,
                    size: 15,
                  ),
                  //EMAIL VERIFIED WARNING
                  !user!.emailVerified
                      ? Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.yellow.shade700,
                              size: 20,
                            ),
                            GestureDetector(
                              onTap: openProfileInfo,
                              child: Text(
                                "verify your email!",
                                style: TextStyle(
                                    color: Colors.yellow.shade700,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                  onPressed: openLoginPage,
                  color: Colors.amber,
                  child: Text("Log In"))
            ],
          );
        }
      },
    );
  }
}
