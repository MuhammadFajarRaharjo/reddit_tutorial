import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/core/providers/community_provider.dart';
import 'package:reddit_tutorial/core/utils.dart';
import 'package:reddit_tutorial/core/widgets/error_screen.dart';
import 'package:reddit_tutorial/models/community_model.dart';
import 'package:reddit_tutorial/themes/pallete.dart';

import '../../../core/widgets/banner_image.dart';
import '../../../core/widgets/loading.dart';
import '../controller/community_controller.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  const EditCommunityScreen({super.key});

  @override
  ConsumerState<EditCommunityScreen> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  Future<void> selectBannerImage() async {
    final res = await imagePicker();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  Future<void> selectProfileImage() async {
    final res = await imagePicker();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save(CommunityModel community) {
    ref.read(communityControllerProvider.notifier).editCommunity(
          community: community,
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
        );
  }

  @override
  void dispose() {
    bannerFile?.delete();
    profileFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameCommunity = ref.watch(nameCommunityProvider);
    final isLoading = ref.watch(communityControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);

    return ref.watch(getCommunityProvider(nameCommunity)).when(
          data: (community) => Scaffold(
            backgroundColor: currentTheme.colorScheme.background,
            appBar: AppBar(
              title: const Text("Edit Community"),
              centerTitle: false,
              elevation: 0,
              actions: [
                TextButton(
                    onPressed: () => save(community), child: const Text("Save"))
              ],
            ),
            body: isLoading
                ? const Loading()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 185,
                          child: Stack(
                            children: [
                              bannerImage(
                                onTap: selectBannerImage,
                                color:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                child: bannerFile != null
                                    ? Image.file(bannerFile!, fit: BoxFit.cover)
                                    : community.banner.isEmpty ||
                                            community.banner ==
                                                Constants.bannerDefault
                                        ? const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 35,
                                          )
                                        : Image.network(
                                            community.banner,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                              // GestureDetector(
                              //   onTap: selectBannerImage,
                              //   child: DottedBorder(
                              //     color:
                              //         currentTheme.textTheme.bodyMedium!.color!,
                              //     dashPattern: const [10, 2],
                              //     borderType: BorderType.RRect,
                              //     radius: const Radius.circular(10),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(30)),
                              //       width: double.infinity,
                              //       height: 150,
                              //       child: bannerFile != null
                              //           ? Image.file(bannerFile!,
                              //               fit: BoxFit.cover)
                              //           : community.banner.isEmpty ||
                              //                   community.banner ==
                              //                       Constants.bannerDefault
                              //               ? const Icon(
                              //                   Icons.camera_alt_outlined,
                              //                   size: 35)
                              //               : Image.network(community.banner,
                              //                   fit: BoxFit.cover),
                              //     ),
                              //   ),
                              // ),

                              Positioned(
                                bottom: 0,
                                left: 20,
                                child: GestureDetector(
                                  onTap: selectProfileImage,
                                  child: CircleAvatar(
                                    backgroundImage: profileFile != null
                                        ? FileImage(profileFile!)
                                        : NetworkImage(community.avatar)
                                            as ImageProvider,
                                    radius: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => const Loading(),
        );
  }
}
