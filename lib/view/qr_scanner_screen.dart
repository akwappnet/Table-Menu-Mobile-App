import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import '../utils/widgets/custom_button.dart';

class QRScannerScreen extends StatefulWidget {

  QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  QRViewController? controller;

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.purple,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scan the QR code',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Text('Cancel', style: TextStyle(fontSize: 16),),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final qr_provider = Provider.of<QRProvider>(context, listen: false);
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      qr_provider.getDataFromQR(scanData.code.toString());
      Future.delayed(Duration(seconds: 2), (){
        Navigator.of(context).pop();
        print(scanData.code.toString());
      });
      controller.pauseCamera();
      controller.resumeCamera();
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

}