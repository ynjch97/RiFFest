import 'package:flutter/material.dart';
import 'package:riffest/constants/box_decorations.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ...List.generate(
                  30,
                  (index) {
                    return FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecorations.test1,
                        child: const Text("data"),
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecorations.test2,
                child: const Text("data"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
