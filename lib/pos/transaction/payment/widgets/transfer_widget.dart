import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/payment_method_list_model.dart';

class TransferWidget extends StatelessWidget {
  const TransferWidget({
    super.key,
    required this.transactionOrderModel,
    required this.paymentMethodListModel,
    required this.paymentMethodName,
  });
  final OrderModel transactionOrderModel;
  final PaymentMethodListModel paymentMethodListModel;
  final String paymentMethodName;

  @override
  Widget build(BuildContext context) {
    // TransactionFileModel transactionFileModel = TransactionFileModel.empty;

    // TrasagetImageorVideoFromGallery() async {
    //   FilePickerResult? filePickerResult =
    //       await FilePicker.platform.pickFiles();
    //   if (filePickerResult != null) {
    //     fileName = filePickerResult.files[0].name;
    //     fileBase64 = base64Encode(filePickerResult.files[0].bytes!.toList());

    //     context.read<TransactionBloc>().add();
    //   } else {
    //     fileName = 'No image selected';
    //     fileBase64 = '';
    //   }
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Price *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Input note...',
            ),
            controller: TextEditingController(
              text: NumberFormat.simpleCurrency(locale: "id-ID").format(
                transactionOrderModel.TotalPrice,
              ),
            ),
            enabled: false,
            readOnly: true,
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Payment *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        const SizedBox(height: 24.0),
        const Text(
          'Upload Image *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            SizedBox(
              height: 48.0,
              child: ElevatedButton(
                onPressed: () {
                  // getImageorVideoFromGallery();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
            // Text(fileName),
          ],
        ),
      ],
    );
  }
}
