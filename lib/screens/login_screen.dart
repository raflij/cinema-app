import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mini_project_cinema_app/components/rounded_button.dart';
import 'package:mini_project_cinema_app/components/rounded_input_field.dart';
import 'package:mini_project_cinema_app/components/rounded_password_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SvgPicture.asset('assets/icons/login.svg',
                        height: size.height * 0.35),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      icon: Icons.person,
                      onChanged: (value) => {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Harus diisi");
                        }
                        return null;
                      },
                      fieldController: emailEditingController,
                    ),
                    RoundedPasswordField(
                      onChanged: (value) => {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Harus diisi");
                        }
                        return null;
                      },
                      fieldController: passwordEditingController,
                    ),
                    RoundedButton(
                        text: "LOGIN",
                        press: () {
                          signIn(context, emailEditingController.text,
                              passwordEditingController.text);
                        },
                        color: 0xFF6D28D9,
                        textColor: Colors.white),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(0xFF6D28D9)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xFF6D28D9),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Berhasil'),
                    ),
                  )
                });

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.message}'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          ),
        );
        // ignore: avoid_print
      }
    }
  }
}
