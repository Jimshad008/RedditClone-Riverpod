import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnikerBar(String message,BuildContext context){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message)));

}
Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}