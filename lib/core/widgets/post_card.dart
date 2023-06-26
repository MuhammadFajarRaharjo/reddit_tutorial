import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/features/posts/controller/post_controller.dart';
import 'package:reddit_tutorial/models/post_model.dart';
import 'package:reddit_tutorial/models/user_model.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:reddit_tutorial/themes/pallete.dart';
import 'package:routemaster/routemaster.dart';

import '../providers/community_provider.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, ref) {
    final isImage = post.type == 'image';
    final isText = post.type == 'text';
    final currentTheme = ref.watch(themeNotifierProvider);
    final user = ref.watch(userProvider);
    final postController = ref.read(postControllerProvider.notifier);

    return Container(
      color: currentTheme.colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: () {
                ref.read(nameCommunityProvider.notifier).state =
                    post.communityName;
                Routemaster.of(context).push(RoutePath.commnuity);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(post.communityProfilePic),
              ),
            ),
            title: Text(
              "r/${post.communityName}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: GestureDetector(
              onTap: () => Routemaster.of(context).push(
                "${RoutePath.profile}/${post.uid}",
              ),
              child: Text(
                "u/${post.userName}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            trailing: (post.uid == user!.uid)
                ? IconButton(
                    onPressed: () => ref
                        .read(postControllerProvider.notifier)
                        .deletePost(post.id, context),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                .copyWith(top: 0),
            child: Text(
              post.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isText
                ? Text(
                    post.description!,
                    style: const TextStyle(color: Colors.grey),
                  )
                : SizedBox(
                    height: isImage
                        ? MediaQuery.of(context).size.height * 0.35
                        : 150,
                    width: double.infinity,
                    child: isImage
                        ? Image.network(post.link!, fit: BoxFit.cover)
                        : AnyLinkPreview(
                            link: post.link!,
                            displayDirection: UIDirection.uiDirectionHorizontal,
                          ),
                  ),
          ),

          // action
          _actionButtonPost(postController, context, user, currentTheme, ref)
        ],
      ),
    );
  }

  Row _actionButtonPost(PostController postController, BuildContext context,
      UserModel user, ThemeData currentTheme, WidgetRef ref) {
    final voteLength = post.upVotes.length - post.downVotes.length;

    return Row(
      children: [
        IconButton(
          onPressed: () => postController.votes(post, 'upVotes', context),
          icon: Icon(
            Constants.up,
            color: post.upVotes.contains(user.uid) ? Colors.red : null,
          ),
        ),
        Text(
          "${voteLength <= 0 ? 'Votes' : voteLength}",
        ),
        IconButton(
          onPressed: () => postController.votes(post, 'downVotes', context),
          icon: Icon(
            Constants.down,
            color: post.downVotes.contains(user.uid) ? Colors.blue : null,
          ),
        ),
        TextButton.icon(
          onPressed: () => Routemaster.of(context).push(
            "${RoutePath.postComment}/${post.id}",
          ),
          icon: const Icon(Icons.comment),
          style: TextButton.styleFrom(
            iconColor: currentTheme.textTheme.bodyMedium?.color,
          ),
          label: Text(
            "${post.commentCount == 0 ? 'Comment' : post.commentCount}",
            style: TextStyle(
              color: currentTheme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
        ref.watch(getCommunityProvider(post.communityName)).when(
              data: (community) {
                if (community.mods.contains(user.uid)) {
                  return IconButton(
                    onPressed: () =>
                        postController.votes(post, 'downVotes', context),
                    icon: const Icon(Icons.admin_panel_settings),
                  );
                }
                return const SizedBox();
              },
              error: (error, stackTrace) =>
                  ErrorScreen(message: error.toString()),
              loading: () => const Loading(),
              skipError: true,
              skipLoadingOnReload: true,
            )
      ],
    );
  }
}
