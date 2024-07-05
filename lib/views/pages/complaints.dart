import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/views/pages/complaint_form.dart';
import 'package:homease/views/pages/complaint_list.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ComplaintFormState> formKey = GlobalKey<ComplaintFormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Get.to(() => ComplaintListPage());
            },
          ),
        ],
      ),
      body: ComplaintForm(key: formKey),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
      )
    );
  }
}
