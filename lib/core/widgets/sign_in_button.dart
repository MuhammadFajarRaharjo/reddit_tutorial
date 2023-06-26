import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/assets.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/themes/pallete.dart';

class SignInBotton extends ConsumerWidget {
  const SignInBotton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      icon: Image.asset(Assets.assetsImagesGoogle, width: 25),
      label: const Text(
        "Continue with Google",
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Pallete.greyColor,
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: () {
        ref.read(authControllerProvider.notifier).signInWithGoogle(context);
      },
    );
  }
}
