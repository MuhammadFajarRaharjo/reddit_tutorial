import 'package:flutter/material.dart';
import 'package:reddit_tutorial/features/auth/screens/login_screen.dart';
import 'package:reddit_tutorial/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/community/screens/add_mods_screen.dart';
import 'features/community/screens/community_screen.dart';
import 'features/community/screens/create_comunity_screen.dart';
import 'features/community/screens/edit_community_screen.dart';
import 'features/community/screens/mod_tools_screen.dart';
import 'features/posts/screens/add_post_type_screen.dart';
import 'features/posts/screens/comment_screen.dart';
import 'features/user_profile/screens/edit_profile_screen.dart';
import 'features/user_profile/screens/user_profile_screen.dart';
import 'routes_path.dart';

final homeRoutes = RouteMap(
  routes: {
    RoutePath.home: (_) => const MaterialPage(child: HomeScreen()),

    // community
    RoutePath.createCommunity: (_) => const MaterialPage(
          child: CreateCommunityScreen(),
        ),
    RoutePath.commnuity: (_) => const MaterialPage(child: CommunityScreen()),
    RoutePath.modTools: (_) => const MaterialPage(child: ModToolsScreen()),
    RoutePath.editCommunityTools: (_) =>
        const MaterialPage(child: EditCommunityScreen()),
    RoutePath.addMods: (_) => const MaterialPage(child: AddModsScreen()),

    // user profile
    "${RoutePath.profile}/:uid": (route) => MaterialPage(
          child: UserProfileScreen(uid: route.pathParameters['uid']!),
        ),
    "${RoutePath.editProfile}/:uid": (route) => MaterialPage(
        child: EditProfileScreen(uid: route.pathParameters['uid']!)),

    // post
    "${RoutePath.addPostType}/:type": (route) => MaterialPage(
          child: AddPostTypeScreen(type: route.pathParameters['type']!),
        ),
    "${RoutePath.postComment}/:postId": (route) => MaterialPage(
          child: CommentScreen(postId: route.pathParameters['postId']!),
        )
  },
);

final loginRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});
