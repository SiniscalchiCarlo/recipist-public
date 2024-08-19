import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class UserAppBar extends StatefulWidget {
  const UserAppBar({super.key});

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Row(
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
                size: 30.0,
              )),
          //EMAIL AND WARNINGS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //EMAIL
              MyText(
                text: user!.email ?? "missing email",
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
                        Text(
                          "verify your email!",
                          style: TextStyle(
                              color: Colors.yellow.shade700,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      );
    } else {
      return MaterialButton(
        onPressed: () {},
        child: Text("Login"),
      );
    }
  }
}
