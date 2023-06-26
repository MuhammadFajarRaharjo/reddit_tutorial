import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/core/widgets/post_card.dart';
import 'package:reddit_tutorial/features/posts/controller/post_controller.dart';

import '../../../core/widgets/comment_card.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final String postId;
  const CommentScreen({required this.postId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  late final TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getPostProvider(widget.postId)).when(
            data: (post) {
              return Column(
                children: [
                  PostCard(post: post),
                  const SizedBox(height: 10),
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Input your comment",
                      filled: true,
                      border: InputBorder.none,
                      suffix: TextButton(
                        onPressed: () {},
                        child: const Text("Kirim"),
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (value) {
                      ref.read(postControllerProvider.notifier).addComment(
                            text: value,
                            postId: post.id,
                            context: context,
                          );
                      commentController.clear();
                    },
                  ),
                  ref.watch(commentOfPostProvider(post.id)).when(
                        data: (comments) => Expanded(
                          child: ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (_, index) => CommentCard(
                              comment: comments[index],
                            ),
                          ),
                        ),
                        error: (error, stackTrace) =>
                            ErrorScreen(message: error.toString()),
                        loading: () => const Loading(),
                      ),
                ],
              );
            },
            error: (error, stackTrace) =>
                ErrorScreen(message: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }
}
