import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// function for show widget snackbar
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

Future<FilePickerResult?> imagePicker() async =>
    await FilePicker.platform.pickFiles(type: FileType.image);
