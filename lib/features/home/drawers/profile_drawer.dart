import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:reddit_tutorial/themes/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawe extends ConsumerWidget {
  const ProfileDrawe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final themeData = ref.watch(themeNotifierProvider);

    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 30),
          ClipOval(
            child: Image.network(
              user?.profileUrl ?? Constants.avatarDefault,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text("u/${user?.name}"),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("My Profile"),
            onTap: () => Routemaster.of(context).push(
              "${RoutePath.profile}/${user!.uid}",
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => ref.read(authControllerProvider.notifier).logOut(),
          ),
          Switch.adaptive(
            value: themeData == Pallete.darkModeAppTheme,
            onChanged: (value) {
              if (value) {
                ref
                    .read(themeNotifierProvider.notifier)
                    .setTheme(ThemeMode.dark);
              } else {
                ref
                    .read(themeNotifierProvider.notifier)
                    .setTheme(ThemeMode.light);
              }
            },
          )
        ],
      )),
    );
  }
}
