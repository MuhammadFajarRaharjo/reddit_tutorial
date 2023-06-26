import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/core/widgets/loading.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/models/community_model.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/banner_image.dart';
import '../../../themes/pallete.dart';
import '../controller/post_controller.dart';

class AddPostTypeScreen extends ConsumerStatefulWidget {
  final String type;
  const AddPostTypeScreen({required this.type, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPostTypeScreenState();
}

class _AddPostTypeScreenState extends ConsumerState<AddPostTypeScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController linkController;
  final List<CommunityModel> communitieList = [];
  File? bannerFile;
  CommunityModel? selectedCommunity;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  Future<void> selectBannerImage() async {
    final res = await imagePicker();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void sharedPost() {
    if (widget.type == 'image' &&
        bannerFile != null &&
        titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).sharedPost(
            context: context,
            title: titleController.text,
            selectedCommunity: selectedCommunity ?? communitieList[0],
            file: bannerFile,
            type: 'image',
          );
    } else if (widget.type == 'text' &&
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).sharedPost(
            context: context,
            title: titleController.text,
            description: descriptionController.text,
            selectedCommunity: selectedCommunity ?? communitieList[0],
            type: 'text',
          );
    } else if (widget.type == 'link' &&
        titleController.text.isNotEmpty &&
        linkController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).sharedPost(
            context: context,
            title: titleController.text.trim(),
            link: linkController.text.trim(),
            selectedCommunity: selectedCommunity ?? communitieList[0],
            type: 'link',
          );
    } else {
      showSnackBar(context, 'Please input all field');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isImage = widget.type == 'image';
    final isText = widget.type == 'text';
    final currentTheme = ref.watch(themeNotifierProvider);
    final isLoading = ref.watch(postControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Post ${widget.type}"),
        actions: [TextButton(onPressed: sharedPost, child: const Text("Save"))],
      ),
      body: isLoading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      hintText: 'Enter title here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLength: 30,
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: isImage,
                    replacement: TextField(
                      controller:
                          isText ? descriptionController : linkController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        hintText: isText
                            ? 'Enter description here'
                            : 'Enter link here',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: isText ? 5 : 1,
                    ),
                    child: bannerImage(
                      color: currentTheme.textTheme.bodyMedium!.color!,
                      onTap: selectBannerImage,
                      child: bannerFile != null
                          ? Image.file(bannerFile!, fit: BoxFit.cover)
                          : const Icon(Icons.camera_alt_outlined, size: 35),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Select Community"),
                  ),
                  ref.watch(userCommunityProvider).when(
                        data: (communities) {
                          communitieList.addAll(communities);
                          return DropdownButton(
                            value: selectedCommunity ?? communities[0],
                            items: communities
                                .map(
                                  (community) => DropdownMenuItem(
                                    value: community,
                                    child: Text(community.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (community) => setState(() {
                              selectedCommunity = community;
                            }),
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorScreen(message: error.toString()),
                        loading: () => const Loading(),
                      )
                ],
              ),
            ),
    );
  }
}
