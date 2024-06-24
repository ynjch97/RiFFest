import 'package:flutter/material.dart';
import 'package:riffest/constants/routes.dart';

class LoginScreen extends StatefulWidget {
  static const routeURL = Routes.loginScreen;
  static const routeName = RoutesName.loginScreen;
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}