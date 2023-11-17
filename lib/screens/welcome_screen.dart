import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mini_project_cinema_app/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // User is already authenticated, schedule navigation to home screen
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, '/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_top.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_bottom.png',
                width: size.width * 0.2,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "WELCOME",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SvgPicture.asset('assets/icons/chat.svg',
                      height: size.height * 0.45),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    color: 0xFF6D28D9,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    color: 0xFFDDD6FE,
                    textColor: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
