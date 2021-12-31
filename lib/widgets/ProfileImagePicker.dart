import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  late String imageUrl;
  final void Function(String imageUrl) saveImage;

  ProfileImagePicker({required this.imageUrl, required this.saveImage});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File profileImage = File('');

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    profileImage = File(imageFile.path);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('users')
        .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');
    await storageRef.putFile(profileImage);
    final imageUrl = await storageRef.getDownloadURL();
    setState(() {
      widget.imageUrl = imageUrl;
    });
    widget.saveImage(widget.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundImage:
              widget.imageUrl.isNotEmpty ? NetworkImage(widget.imageUrl) : null,
          radius: 64,
        ),
        CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            child: IconButton(
                onPressed: pickImage, icon: Icon(Icons.camera_alt_rounded)))
      ],
    );
  }
}
