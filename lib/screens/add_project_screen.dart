import 'dart:typed_data';
import 'package:codegram/resources/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  Uint8List? _image;
  bool _isUploading = false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void clearScreen() {
    _projectNameController.text = "";
    _projectDescController.text = "";
    _linkController.text = "";
    _image = null;
  }

  void addProject(projName, description, file, uid, username, profImage,
      projectLink) async {
    setState(() {
      _isUploading = true;
    });
    try {
      String res = await FirestoreMethods().uploadProject(
        projName,
        description,
        file,
        uid,
        username,
        profImage,
        projectLink,
      );
      if (res == "Success") {
        setState(() {
          _isUploading = false;
        });
        showSnackBar("Project Posted!", context);
        clearScreen();
      } else {
        setState(() {
          _isUploading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectDescController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Project Name'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: _isUploading
          ? const LinearProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: primaryColor),
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
                                  ? const NetworkImage(
                                      'https://www.shutterstock.com/image-vector/blue-folder-icon-isolated-on-260nw-1501848521.jpg')
                                  : MemoryImage(_image!) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
                              color: primaryColor,
                            ),
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: blueColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Project Name:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: _projectNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter project name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: _projectDescController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Enter project description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Github/Project Link:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Expanded(
                    child: TextField(
                      controller: _linkController,
                      decoration: const InputDecoration(
                        hintText: 'Enter link',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => addProject(
                          _projectNameController.text,
                          _projectDescController.text,
                          _image!,
                          user.uid,
                          user.username,
                          user.photoUrl,
                          _linkController.text),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
