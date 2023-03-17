import 'dart:typed_data';

import 'package:codegram/models/user.dart';
import 'package:codegram/resources/firestore_methods.dart';
import 'package:codegram/utils/colors.dart';
import 'package:codegram/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? _image;
  bool _isUploading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void uploadData(uid, username, bio, ogUsername, ogbio, ogPhotoUrl) async {
    setState(() {
      _isUploading = true;
    });
    try {
      String ret = await FirestoreMethods().saveEditedProfile(
          uid, username, bio, ogUsername, ogbio, _image, ogPhotoUrl);
      if (ret == "Success") {
        setState(() {
          _isUploading = false;
        });
        showSnackBar("Posted!", context);
      } else {
        setState(() {
          _isUploading = false;
        });
        showSnackBar(ret, context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: mobileBackgroundColor,
      ),
      body: _isUploading
          ? const LinearProgressIndicator()
          : Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: primaryColor),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: secondaryColor.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _image == null
                                    ? NetworkImage(user.photoUrl)
                                    : MemoryImage(_image!) as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: primaryColor,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 1, left: 1),
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.edit,
                                  color: blueColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField(
                        "Username", user.username, false, _usernameController),
                    buildTextField("Email", user.email, true, _emailController),
                    buildTextField("Bio", user.bio, false, _bioController),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: blueColor,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => uploadData(
                              user.uid,
                              _usernameController.text,
                              _bioController.text,
                              user.username,
                              user.bio,
                              user.photoUrl),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool readonly,
      TextEditingController _textController) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: _textController,
        readOnly: readonly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
