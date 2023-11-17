// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mini_project_cinema_app/screens/home_screen.dart';
import 'package:mini_project_cinema_app/screens/login_screen.dart';
import 'package:mini_project_cinema_app/screens/notification_screen.dart';
import 'package:mini_project_cinema_app/screens/signup_screen.dart';
import 'package:mini_project_cinema_app/screens/welcome_screen.dart';

class Routes {
  Routes() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Project Cinema App',
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/notification': (context) => NotificationScreen(),
        // Add more routes as needed
      },
    ));
  }
}
