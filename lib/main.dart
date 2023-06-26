import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/widgets/loading.dart';
import 'features/auth/controller/auth_controller.dart';
import 'models/user_model.dart';
import 'routes.dart';
import 'firebase_options.dart';
import 'themes/pallete.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  Future<void> getUser(String uid) async {
    // get user from firestore
    userModel =
        await ref.watch(authControllerProvider.notifier).getUserData(uid);
    // update data user model to userProvider
    ref.read(userProvider.notifier).update((state) => userModel);
    // use setState not to use initState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(
          data: (user) => MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ref.watch(themeNotifierProvider),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (user != null) {
                getUser(user.uid);
                if (userModel != null) return homeRoutes;
              }
              return loginRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => const Loading(),
        );
  }
}
