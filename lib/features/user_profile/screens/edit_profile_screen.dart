import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/banner_image.dart';
import '../../../core/widgets/error_screen.dart';
import '../../../core/widgets/loading.dart';
import '../../../themes/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/user_profile_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const EditProfileScreen({required this.uid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? bannerFile;
  File? profileFile;
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    bannerFile?.delete();
    profileFile?.delete();
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

  Future<void> selectProfileImage() async {
    final res = await imagePicker();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save() {
    ref.read(userProfileControllerProvider.notifier).editUserProfile(
          name: nameController.text,
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(userProfileControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);

    return ref.watch(getUserDataRepository(widget.uid)).when(
          data: (community) => Scaffold(
            backgroundColor: currentTheme.colorScheme.background,
            appBar: AppBar(
              title: const Text("Edit Community"),
              centerTitle: false,
              elevation: 0,
              actions: [TextButton(onPressed: save, child: const Text("Save"))],
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
                                color:
                                    currentTheme.textTheme.bodyMedium!.color!,
                                onTap: selectBannerImage,
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
                                        : NetworkImage(community.profileUrl)
                                            as ImageProvider,
                                    radius: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => const Loading(),
        );
  }
}
