import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/providers/community_provider.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';

import '../../auth/controller/auth_controller.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  const AddModsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsScreenState();
}

class _AddModsScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};
  int ctr = 0;

  @override
  void initState() {
    super.initState();

    // mengambil semua data mods
    Future.microtask(() {
      final community =
          ref.read(getCommunityProvider(ref.watch(nameCommunityProvider)));
      community.whenData((community) {
        setState(() {
          uids.addAll(community.mods);
        });
      });
    });
  }

  @override
  void dispose() {
    uids.clear();
    super.dispose();
  }

  void addCheck(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeCheck(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ref.read(communityControllerProvider.notifier).addMods(
                      ref.watch(nameCommunityProvider),
                      uids.toList(),
                      context,
                    );
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: ref
          .watch(getCommunityProvider(ref.watch(nameCommunityProvider)))
          .when(
            data: (community) {
              return ListView.builder(
                itemCount: community.members.length,
                itemBuilder: (context, index) {
                  return ref
                      .watch(getUserDataRepository(community.members[index]))
                      .when(
                        data: (user) {
                          return CheckboxListTile(
                            value: uids.contains(user.uid),
                            onChanged: (val) {
                              if (val!) {
                                addCheck(user.uid);
                              } else {
                                removeCheck(user.uid);
                              }
                            },
                            title: Text(user.name),
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorScreen(message: error.toString()),
                        loading: () => const Loading(),
                      );
                },
              );
            },
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }
}
