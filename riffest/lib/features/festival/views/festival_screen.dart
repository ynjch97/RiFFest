import 'package:flutter/material.dart';
import 'package:riffest/constants/routes.dart';

class FestivalScreen extends StatefulWidget {
  static const routeURL = Routes.festivalScreen;
  static const routeName = RoutesName.festivalScreen;

  const FestivalScreen({super.key});

  @override
  State<FestivalScreen> createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
