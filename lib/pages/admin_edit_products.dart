// lib/pages/admin_edit_products.dart

import 'package:flutter/foundation.dart'; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/storage_service.dart';
import '../theme/colors.dart';
import '../widgets/default_product.dart'; // Import DefaultProduct
import '../widgets/admin_edit_form.dart'; // Import AdminEditForm

class AdminEditProducts extends StatefulWidget {
  final Map<String, dynamic> document;
  final String category;

  AdminEditProducts({required this.document, required this.category});

  @override
  _AdminEditProductsState createState() => _AdminEditProductsState();
}

class _AdminEditProductsState extends State<AdminEditProducts> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _productIDController;
  late TextEditingController _productNameController;
  late TextEditingController _irPriceController;
  late TextEditingController _quantityController;
  late TextEditingController _bonusValueController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _gitURLController;
  late TextEditingController _imagePathController;
  late TextEditingController _retailPriceController;
  late TextEditingController _salesPriceController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _productIDController =
        TextEditingController(text: widget.document['productID']);
    _productNameController =
        TextEditingController(text: widget.document['productName']);
    _irPriceController =
        TextEditingController(text: widget.document['irPrice'].toString());
    _quantityController =
        TextEditingController(text: widget.document['quantity'].toString());
    _bonusValueController =
        TextEditingController(text: widget.document['bonusValue'].toString());
    _categoryController =
        TextEditingController(text: widget.document['category']);
    _descriptionController =
        TextEditingController(text: widget.document['description']);
    _gitURLController = TextEditingController(text: widget.document['gitURL']);
    _imagePathController =
        TextEditingController(text: widget.document['imagePath']);
    _retailPriceController =
        TextEditingController(text: widget.document['retailPrice'].toString());
    _salesPriceController =
        TextEditingController(text: widget.document['salesPrice'].toString());
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
        _imagePathController.text = imageUrl;
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedProduct = {
        'productID': _productIDController.text,
        'productName': _productNameController.text,
        'irPrice': int.parse(_irPriceController.text),
        'quantity': int.parse(_quantityController.text),
        'bonusValue': int.parse(_bonusValueController.text),
        'category': _categoryController.text,
        'description': _descriptionController.text,
        'gitURL': _gitURLController.text,
        'imagePath': _imagePathController.text,
        'retailPrice': int.parse(_retailPriceController.text),
        'salesPrice': int.parse(_salesPriceController.text),
      };

      await productsCollection
          .doc(widget.document['id'])
          .update(updatedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminEditForm(
      title: 'Edit Product',
      formKey: _formKey,
      formFields: [
        Center(
          child: _image != null
              ? kIsWeb
                  ? Image.network(_imagePathController.text,
                      height: 100, width: 100)
                  : Image.file(_image!, height: 100, width: 100)
              : (_imagePathController.text.isNotEmpty
                  ? Image.network(
                      _imagePathController.text,
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return DefaultProduct.getDefaultProductImage(
                            size: 100.0);
                      },
                    )
                  : (imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return DefaultProduct.getDefaultProductImage(
                                size: 100.0);
                          },
                        )
                      : DefaultProduct.getDefaultProductImage(size: 100.0))),
        ),
        TextFormField(
          controller: _productIDController,
          decoration: InputDecoration(
            labelText: 'Product ID',
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
              return 'Please enter Product ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _productNameController,
          decoration: InputDecoration(
            labelText: 'Product Name',
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
              return 'Please enter Product Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _irPriceController,
          decoration: InputDecoration(
            labelText: 'IR Price',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter IR Price';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _quantityController,
          decoration: InputDecoration(
            labelText: 'Quantity',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Quantity';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _bonusValueController,
          decoration: InputDecoration(
            labelText: 'Bonus Value',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Bonus Value';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _categoryController,
          decoration: InputDecoration(
            labelText: 'Category',
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
              return 'Please enter Category';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
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
              return 'Please enter Description';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _gitURLController,
          decoration: InputDecoration(
            labelText: 'Git URL',
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
              return 'Please enter Git URL';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _imagePathController,
          decoration: InputDecoration(
            labelText: 'Image Path',
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
              return 'Please enter Image Path';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _retailPriceController,
          decoration: InputDecoration(
            labelText: 'Retail Price',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Retail Price';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _salesPriceController,
          decoration: InputDecoration(
            labelText: 'Sales Price',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Sales Price';
            }
            return null;
          },
        ),
      ],
      onSave: _saveProduct,
    );
  }
}
