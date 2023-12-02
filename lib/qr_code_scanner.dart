import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String qrResult = "Scanned QR data";

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrResult = qrCode;
      });

      // Check if the scanned QR code is a URL
      if (qrCode != '-1' && Uri.parse(qrCode).isAbsolute) {
        _launchURL(qrCode);
      }
    } on PlatformException {
      setState(() {
        qrResult = "Failed to read QR code";
      });
    }
  }


  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Code Scanner"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              qrResult,
              style: TextStyle(color: Colors.deepPurpleAccent),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: scanQR,
              child: Text('Scan QR code'),
            ),
          ],
        ),
      ),
    );
  }
}
