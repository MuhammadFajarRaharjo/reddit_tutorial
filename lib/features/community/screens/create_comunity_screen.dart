import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/themes/pallete.dart';

import '../controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final textController = TextEditingController();

  void createCommunity() {
    ref
        .watch(communityControllerProvider.notifier)
        .createCommunity(textController.text.trim(), context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create a community")),
      body: isLoading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Community name"),
                  const SizedBox(height: 10),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Pallete.greyColor,
                      filled: true,
                      hintText: "community_name",
                    ),
                    maxLength: 21,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text("Create community"),
                  ),
                ],
              ),
            ),
    );
  }
}
