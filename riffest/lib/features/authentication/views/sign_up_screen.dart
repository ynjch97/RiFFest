import 'package:flutter/material.dart';
import 'package:riffest/constants/routes.dart';

class SignUpScreen extends StatefulWidget {
  static const routeURL = Routes.signUpScreen;
  static const routeName = RoutesName.signUpScreen;

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("signup"),
        ),
      ),
    );
  }
}
