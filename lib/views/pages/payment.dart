import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/models/payment_model.dart';
import 'package:homease/views/pages/update_payment.dart';
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
      ),
      body: Column(
        children: [
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
    showDialog(
      context: context,
      builder: (context) {
        return UpdatePaymentDialog(payment: payment);
      },
    );
  }
}
