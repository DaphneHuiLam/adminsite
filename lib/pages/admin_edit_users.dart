// lib/pages/admin_edit_users.dart

import 'package:flutter/foundation.dart'; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/storage_service.dart';
import '../theme/colors.dart';
import '../widgets/default_profile.dart'; // Import DefaultProfile
import '../widgets/admin_edit_form.dart'; // Import AdminEditForm

class AdminEditUsers extends StatefulWidget {
  final Map<String, dynamic> user;
  final Function onSave;

  AdminEditUsers({required this.user, required this.onSave});

  @override
  _AdminEditUsersState createState() => _AdminEditUsersState();
}

class _AdminEditUsersState extends State<AdminEditUsers> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _irIDController;
  late TextEditingController _irNameController;
  late TextEditingController _emailController;
  late TextEditingController _userTypeController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _profilePictureController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _irIDController = TextEditingController(text: widget.user['irID']);
    _irNameController = TextEditingController(text: widget.user['irName']);
    _emailController = TextEditingController(text: widget.user['email']);
    _userTypeController = TextEditingController(text: widget.user['userType']);
    _nameController = TextEditingController(text: widget.user['name']);
    _passwordController = TextEditingController(text: widget.user['password']);
    _profilePictureController =
        TextEditingController(text: widget.user['profilePicture']);
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (_profilePictureController.text.isNotEmpty) {
      try {
        String downloadURL = await _storageService
            .getDownloadURL(_profilePictureController.text);
        setState(() {
          imageUrl = downloadURL;
        });
        print('Image loaded successfully: $imageUrl');
      } catch (e) {
        print('Error loading image: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Upload new image and get download URL
      String? imageUrl = await _storageService.uploadFile(_image!);
      if (imageUrl != null) {
        setState(() {
          _profilePictureController.text = imageUrl;
          this.imageUrl = imageUrl;
        });
        print('Image uploaded successfully: $imageUrl');
      }
    }
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? imageUrl;

      if (_image != null) {
        imageUrl = await _storageService.uploadFile(_image!);
      } else {
        imageUrl = _profilePictureController.text;
      }

      final updatedUser = {
        'irID': _irIDController.text,
        'irName': _irNameController.text,
        'email': _emailController.text,
        'userType': _userTypeController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
        'profilePicture': imageUrl,
      };

      await users.doc(widget.user['id']).update(updatedUser);
      widget.onSave();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminEditForm(
      title: 'Edit User',
      formKey: _formKey,
      formFields: [
        Center(
          child: _image != null
              ? kIsWeb
                  ? Image.network(_profilePictureController.text,
                      height: 100, width: 100)
                  : Image.file(_image!, height: 100, width: 100)
              : (imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return DefaultProfile.getDefaultProfileImage(
                            size: 100.0);
                      },
                    )
                  : DefaultProfile.getDefaultProfileImage(size: 100.0)),
        ),
        TextFormField(
          controller: _irIDController,
          decoration: InputDecoration(
            labelText: 'IR ID',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter IR ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _irNameController,
          decoration: InputDecoration(
            labelText: 'IR Name',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter IR Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Email';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _userTypeController,
          decoration: InputDecoration(
            labelText: 'User Type',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter User Type';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Password';
            }
            return null;
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _profilePictureController,
                decoration: InputDecoration(
                  labelText: 'Profile Picture URL',
                  labelStyle: TextStyle(color: textColor3),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Profile Picture URL or upload an image';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.image, color: primaryColor1),
              onPressed: _pickImage,
            ),
          ],
        ),
      ],
      onSave: _saveUser,
    );
  }
}


/*
import 'package:flutter/foundation.dart'; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/storage_service.dart';
import '../theme/colors.dart';
import '../widgets/default_profile.dart'; // Import DefaultProfile
import '../widgets/admin_edit_form.dart'; // Import AdminEditForm

class AdminEditUsers extends StatefulWidget {
  final Map<String, dynamic> user;
  final Function onSave;

  AdminEditUsers({required this.user, required this.onSave});

  @override
  _AdminEditUsersState createState() => _AdminEditUsersState();
}

class _AdminEditUsersState extends State<AdminEditUsers> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _irIDController;
  late TextEditingController _irNameController;
  late TextEditingController _emailController;
  late TextEditingController _userTypeController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _profilePictureController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _irIDController = TextEditingController(text: widget.user['irID']);
    _irNameController = TextEditingController(text: widget.user['irName']);
    _emailController = TextEditingController(text: widget.user['email']);
    _userTypeController = TextEditingController(text: widget.user['userType']);
    _nameController = TextEditingController(text: widget.user['name']);
    _passwordController = TextEditingController(text: widget.user['password']);
    _profilePictureController =
        TextEditingController(text: widget.user['profilePicture']);
    loadImage();
  }

  Future<void> loadImage() async {
    try {
      String downloadURL = await FirebaseStorage.instance
          .ref('path/to/your/image.jpg') // Replace with actual path
          .getDownloadURL();
      setState(() {
        imageUrl = downloadURL;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Upload new image and get download URL
      String? imageUrl = await _storageService.uploadFile(_image!);
      setState(() {
        _profilePictureController.text = imageUrl;
      });
    }
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? imageUrl;

      if (_image != null) {
        imageUrl = await _storageService.uploadFile(_image!);
      } else {
        imageUrl = _profilePictureController.text;
      }

      final updatedUser = {
        'irID': _irIDController.text,
        'irName': _irNameController.text,
        'email': _emailController.text,
        'userType': _userTypeController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
        'profilePicture': imageUrl,
      };

      await users.doc(widget.user['id']).update(updatedUser);
      widget.onSave();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminEditForm(
      title: 'Edit User',
      formKey: _formKey,
      formFields: [
        Center(
          child: _image != null
              ? kIsWeb
                  ? Image.network(_profilePictureController.text,
                      height: 100, width: 100)
                  : Image.file(_image!, height: 100, width: 100)
              : (_profilePictureController.text.isNotEmpty
                  ? Image.network(
                      _profilePictureController.text,
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return DefaultProfile.getDefaultProfileImage(
                            size: 100.0);
                      },
                    )
                  : (imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return DefaultProfile.getDefaultProfileImage(
                                size: 100.0);
                          },
                        )
                      : DefaultProfile.getDefaultProfileImage(size: 100.0))),
        ),
        TextFormField(
          controller: _irIDController,
          decoration: InputDecoration(
            labelText: 'IR ID',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter IR ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _irNameController,
          decoration: InputDecoration(
            labelText: 'IR Name',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter IR Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Email';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _userTypeController,
          decoration: InputDecoration(
            labelText: 'User Type',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter User Type';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Password';
            }
            return null;
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _profilePictureController,
                decoration: InputDecoration(
                  labelText: 'Profile Picture URL',
                  labelStyle: TextStyle(color: textColor3),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Profile Picture URL or upload an image';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.image, color: primaryColor1),
              onPressed: _pickImage,
            ),
          ],
        ),
      ],
      onSave: _saveUser,
    );
  }
}
*/