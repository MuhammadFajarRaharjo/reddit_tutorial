import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/providers/community_provider.dart';
import '../../../core/widgets/error_screen.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/post_card.dart';
import '../../../models/community_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCommunity = ref.watch(nameCommunityProvider);
    return Scaffold(
      body: ref.watch(getCommunityProvider(nameCommunity)).when(
            data: (community) {
              return _Body(community, ref);
            },
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.community, this.ref);

  final CommunityModel community;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [_header(), _headerContent(context)];
      },
      body: ref.watch(communityPostsProvider(community.name)).when(
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

  SliverPadding _headerContent(BuildContext context) {
    // take uid user
    final uid = ref.watch(userProvider.select((value) => value!.uid));
    return SliverPadding(
      padding: const EdgeInsets.all(15),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundImage: NetworkImage(community.avatar),
                radius: 35,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "r/${community.name}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Visibility(
                  visible: community.mods.contains(uid),
                  replacement: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => ref
                        .read(communityControllerProvider.notifier)
                        .updateMembersCommunity(community, context),
                    child: Text(
                        community.members.contains(uid) ? "Joined" : "Join"),
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () =>
                        Routemaster.of(context).push(RoutePath.modTools),
                    child: const Text("Mod tools"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("${community.members.length} members"),
          ],
        ),
      ),
    );
  }

  SliverAppBar _header() {
    return SliverAppBar(
      expandedHeight: 150,
      floating: true,
      snap: true,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              community.banner,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
