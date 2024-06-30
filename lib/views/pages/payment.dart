import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/models/payment_model.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:homease/core/controllers/payment_controller.dart';
import 'package:image_picker/image_picker.dart';

class PaymentPage extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'payments'.tr, clr: AppTheme.primaryColor),
        // backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Faded line between AppBar and body
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.0),
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (paymentController.payments.isEmpty) {
                return Center(child: Text('no_payments_available'.tr));
              } else {
                return ListView.builder(
                  itemCount: paymentController.payments.length,
                  itemBuilder: (context, index) {
                    final payment = paymentController.payments[index];
                    return ListTile(
                      leading: Icon(Icons.payment, color: AppTheme.primaryColor),
                      title: Text(payment.typeOfPayment),
                      subtitle: Text(payment.paymentMethod),
                      trailing: Text(
                        '\$${payment.billAmount.toString()}',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        _showUpdateDialog(context, payment);
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Payment payment) {
    final typeOfPaymentController = TextEditingController(text: payment.typeOfPayment);
    final paymentMethodController = TextEditingController(text: payment.paymentMethod);
    final billAmountController = TextEditingController(text: payment.billAmount.toString());
    XFile? selectedFile;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Payment'),
          content: Column(
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
                  selectedFile = await picker.pickImage(source: ImageSource.gallery);
                },
                child: Text('Select Payment Proof'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedPayment = payment.copyWith(
                  typeOfPayment: typeOfPaymentController.text,
                  paymentMethod: paymentMethodController.text,
                  billAmount: double.parse(billAmountController.text),
                  paymentProof: selectedFile?.path ?? payment.paymentProof,
                );
                paymentController.updatePayment(payment.id!, updatedPayment);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
