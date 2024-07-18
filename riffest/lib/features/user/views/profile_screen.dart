import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/authentication/views/sign_up_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: GestureDetector(
          onTap: () {
            ref.read(authRepo).emailSignOut();
            context.goNamed(SignUpScreen.routeName);
          },
          child: const Text(
            "Profile",
            selectionColor: Colors.blueAccent,
            style: TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }
}
