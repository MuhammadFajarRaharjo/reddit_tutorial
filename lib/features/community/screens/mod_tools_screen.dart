import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/routes_path.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends ConsumerStatefulWidget {
  const ModToolsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ModToolsScreenState();
}

class _ModToolsScreenState extends ConsumerState<ModToolsScreen> {
  @override
  Widget build(BuildContext context) {
    final route = Routemaster.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Mod Tools")),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text("Add Modetator"),
            onTap: () => route.push(RoutePath.addMods),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Community"),
            onTap: () => route.push(RoutePath.editCommunityTools),
          ),
        ],
      ),
    );
  }
}
