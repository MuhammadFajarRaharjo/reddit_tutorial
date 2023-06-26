import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/user_profile/controller/user_profile_controller.dart';
import 'package:reddit_tutorial/models/user_model.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/widgets/error_screen.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/post_card.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getUserDataRepository(uid)).when(
            data: (user) {
              return _Body(user, ref);
            },
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.user, this.ref);

  final UserModel user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [_header(context), _content()];
      },
      body: ref.watch(postsUserProvider(user.uid)).when(
            data: (posts) => ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostCard(post: posts[index]),
            ),
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }

  SliverPadding _content() {
    return SliverPadding(
      padding: const EdgeInsets.all(15),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "u/${user.name}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("${user.karma} karma"),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }

  SliverAppBar _header(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: true,
      snap: true,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              user.banner,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(20).copyWith(bottom: 70),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profileUrl),
              radius: 45,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(20),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Routemaster.of(context)
                  .push("${RoutePath.editProfile}/${user.uid}"),
              child: const Text("Edit Profile"),
            ),
          ),
        ],
      ),
    );
  }
}
