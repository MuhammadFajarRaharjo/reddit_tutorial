import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/widgets/post_card.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/features/posts/controller/post_controller.dart';

import '../../core/widgets/error_screen.dart';
import '../../core/widgets/loading.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userCommunityProvider).when(
          data: (communities) => ref.watch(userPostProvider(communities)).when(
                data: (posts) {
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) =>
                        PostCard(post: posts[index]),
                  );
                },
                error: (error, stackTrace) {
                  if (kDebugMode) {
                    print(error);
                  }
                  return ErrorScreen(message: error.toString());
                },
                loading: () => const Loading(),
              ),
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => const Loading(),
        );
  }
}
