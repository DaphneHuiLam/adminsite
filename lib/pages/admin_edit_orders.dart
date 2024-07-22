// lib/pages/admin_edit_orders.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/colors.dart';
import '../widgets/admin_edit_form.dart';

class AdminEditOrders extends StatefulWidget {
  final Map<String, dynamic> order;
  final Function onSave;

  AdminEditOrders({required this.order, required this.onSave});

  @override
  _AdminEditOrdersState createState() => _AdminEditOrdersState();
}

class _AdminEditOrdersState extends State<AdminEditOrders> {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('Orders');
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _orderIDController;
  late TextEditingController _irNameController;
  late TextEditingController _orderStatusController;
  late TextEditingController _purchaseDateController;
  late TextEditingController _assignStatusController;
  late TextEditingController _irIDController;
  late TextEditingController _orderReceivedController;
  late TextEditingController _order1ProductIDController;
  late TextEditingController _order1ProductNameController;
  late TextEditingController _order1QuantityController;
  late TextEditingController _order2ProductIDController;
  late TextEditingController _order2ProductNameController;
  late TextEditingController _order2QuantityController;

  @override
  void initState() {
    super.initState();
    _orderIDController = TextEditingController(text: widget.order['orderID']);
    _irNameController = TextEditingController(text: widget.order['irName']);
    _orderStatusController =
        TextEditingController(text: widget.order['orderStatus']);
    _purchaseDateController =
        TextEditingController(text: widget.order['purchaseDate']);
    _assignStatusController =
        TextEditingController(text: widget.order['assignStatus']);
    _irIDController = TextEditingController(text: widget.order['irID']);
    _orderReceivedController =
        TextEditingController(text: widget.order['orderReceived']);
    _order1ProductIDController =
        TextEditingController(text: widget.order['order1']?['productID']);
    _order1ProductNameController =
        TextEditingController(text: widget.order['order1']?['productName']);
    _order1QuantityController = TextEditingController(
        text: widget.order['order1']?['quantity']?.toString());
    _order2ProductIDController =
        TextEditingController(text: widget.order['order2']?['productID']);
    _order2ProductNameController =
        TextEditingController(text: widget.order['order2']?['productName']);
    _order2QuantityController = TextEditingController(
        text: widget.order['order2']?['quantity']?.toString());
  }

  Future<void> _saveOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedOrder = {
        'orderID': _orderIDController.text,
        'irName': _irNameController.text,
        'orderStatus': _orderStatusController.text,
        'purchaseDate': _purchaseDateController.text,
        'assignStatus': _assignStatusController.text,
        'irID': _irIDController.text,
        'orderReceived': _orderReceivedController.text,
        'order1': {
          'productID': _order1ProductIDController.text,
          'productName': _order1ProductNameController.text,
          'quantity': int.parse(_order1QuantityController.text),
        },
        'order2': {
          'productID': _order2ProductIDController.text,
          'productName': _order2ProductNameController.text,
          'quantity': int.parse(_order2QuantityController.text),
        },
      };

      await ordersCollection.doc(widget.order['id']).update(updatedOrder);
      widget.onSave();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminEditForm(
      title: 'Edit Order',
      formKey: _formKey,
      formFields: [
        TextFormField(
          controller: _orderIDController,
          decoration: InputDecoration(
            labelText: 'Order ID',
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
              return 'Please enter Order ID';
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
          controller: _orderStatusController,
          decoration: InputDecoration(
            labelText: 'Order Status',
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
              return 'Please enter Order Status';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _purchaseDateController,
          decoration: InputDecoration(
            labelText: 'Purchase Date',
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
              return 'Please enter Purchase Date';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _assignStatusController,
          decoration: InputDecoration(
            labelText: 'Assign Status',
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
              return 'Please enter Assign Status';
            }
            return null;
          },
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
          controller: _orderReceivedController,
          decoration: InputDecoration(
            labelText: 'Order Received',
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
              return 'Please enter Order Received';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order1ProductIDController,
          decoration: InputDecoration(
            labelText: 'Order1 Product ID',
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
              return 'Please enter Order1 Product ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order1ProductNameController,
          decoration: InputDecoration(
            labelText: 'Order1 Product Name',
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
              return 'Please enter Order1 Product Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order1QuantityController,
          decoration: InputDecoration(
            labelText: 'Order1 Quantity',
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
              return 'Please enter Order1 Quantity';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order2ProductIDController,
          decoration: InputDecoration(
            labelText: 'Order2 Product ID',
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
              return 'Please enter Order2 Product ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order2ProductNameController,
          decoration: InputDecoration(
            labelText: 'Order2 Product Name',
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
              return 'Please enter Order2 Product Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _order2QuantityController,
          decoration: InputDecoration(
            labelText: 'Order2 Quantity',
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
              return 'Please enter Order2 Quantity';
            }
            return null;
          },
        ),
      ],
      onSave: _saveOrder,
    );
  }
}
