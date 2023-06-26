import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/providers/community_provider.dart';
import '../../../routes_path.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text("Create a comunity"),
              leading: const Icon(Icons.add),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Routemaster.of(context).push(RoutePath.createCommunity);
              },
            ),

            // community user
            ref.watch(userCommunityProvider).when(
                  data: (data) => Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final community = data[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(community.avatar),
                          ),
                          title: Text("r/${community.name}"),
                          onTap: () {
                            ref
                                .read(nameCommunityProvider.notifier)
                                .update((state) => community.name);
                            Routemaster.of(context).push(RoutePath.commnuity);
                          },
                        );
                      },
                    ),
                  ),
                  error: (error, stackTrace) =>
                      ErrorScreen(message: error.toString()),
                  loading: () => const Loading(),
                ),
          ],
        ),
      ),
    );
  }
}
