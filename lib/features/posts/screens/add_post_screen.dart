import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = Routemaster.of(context);

    const sizeBox = 100.0;
    const sizeIcon = 50.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => route.push("${RoutePath.addPostType}/image"),
          child: SizedBox(
            width: sizeBox,
            height: sizeBox,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, size: sizeIcon),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => route.push("${RoutePath.addPostType}/text"),
          child: SizedBox(
            width: sizeBox,
            height: sizeBox,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.font_download_outlined, size: sizeIcon),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => route.push("${RoutePath.addPostType}/link"),
          child: SizedBox(
            width: sizeBox,
            height: sizeBox,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.link_outlined, size: sizeIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
