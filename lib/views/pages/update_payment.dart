import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/controllers/payment_controller.dart';
import 'package:homease/core/models/payment_model.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePaymentDialog extends StatefulWidget {
  final Payment payment;

  UpdatePaymentDialog({required this.payment});

  @override
  _UpdatePaymentDialogState createState() => _UpdatePaymentDialogState();
}

class _UpdatePaymentDialogState extends State<UpdatePaymentDialog> {
  late TextEditingController typeOfPaymentController;
  late TextEditingController paymentMethodController;
  late TextEditingController billAmountController;
  XFile? selectedFile;

  @override
  void initState() {
    super.initState();
    typeOfPaymentController =
        TextEditingController(text: widget.payment.typeOfPayment);
    paymentMethodController =
        TextEditingController(text: widget.payment.paymentMethod);
    billAmountController =
        TextEditingController(text: widget.payment.billAmount.toString());
  }

  @override
  void dispose() {
    typeOfPaymentController.dispose();
    paymentMethodController.dispose();
    billAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Payment'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeOfPaymentController,
              decoration: InputDecoration(labelText: 'Type of Payment'),
            ),
            TextField(
              controller: paymentMethodController,
              decoration: InputDecoration(labelText: 'Payment Method'),
            ),
            TextField(
              controller: billAmountController,
              decoration: InputDecoration(labelText: 'Bill Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final file =
                    await picker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  setState(() {
                    selectedFile = file;
                  });
                }
              },
              child: Text('Select Payment Proof'),
            ),
            if (selectedFile != null)
              SizedBox(
                height: 100,
                child: Image.file(
                  File(selectedFile!.path),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
       TextButton(
  onPressed: () {
    print('Type of Payment Controller Text: ${typeOfPaymentController.text}');
    print('Payment Method Controller Text: ${paymentMethodController.text}');
    print('Bill Amount Controller Text: ${billAmountController.text}');
    print('Selected File Path: ${selectedFile?.path}');
    
    final updatedPayment = widget.payment.copyWith(
      typeOfPayment: typeOfPaymentController.text,
      paymentMethod: paymentMethodController.text,
      billAmount: double.parse(billAmountController.text),
      paymentProof: selectedFile?.path ?? widget.payment.paymentProof,
    );
    
    print('Updated Payment: ${updatedPayment.toJson()}'); // Debug print
    
    final paymentController = Get.find<PaymentController>();
    paymentController.updatePayment(widget.payment.id!, updatedPayment);
    
    Navigator.of(context).pop();
  },
  child: Text('Update'),
)
      ],
    );
  }
}
