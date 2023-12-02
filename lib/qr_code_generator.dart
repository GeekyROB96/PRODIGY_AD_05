import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({Key? key}) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  TextEditingController qcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Code Generator"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (qcontroller.text.isNotEmpty)
                QrImageView(data: qcontroller.text, size: 200),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: TextField(
                  controller: qcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter data",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: "Enter your data",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                 setState(() {
                   QrImageView(data: qcontroller.text, size: 200);
                 });
                },
                child: Text("Generate QR code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
