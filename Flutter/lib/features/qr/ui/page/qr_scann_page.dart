import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:registration_ui/navigation/button_navbar_page.dart';

class QrScannPage extends StatefulWidget {
  const QrScannPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannPageState();
}

class _QrScannPageState extends State<QrScannPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool _flashOn = false;

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
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ButtonNavbarPage(),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent.withOpacity(1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Container(
                          child: IconButton(
                              onPressed: () async {
                                await controller!.toggleFlash();
                                setState(() {
                                  _flashOn = !_flashOn;
                                });
                              },
                              icon: Icon(
                                _flashOn
                                    ? Icons.flash_on_outlined
                                    : Icons.flash_off_outlined,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: (result != null)
                        ? Text(
                            'Data: ${result!.code}',
                            style: TextStyle(color: Colors.white),
                          )
                        : Text('Scan a code'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                              onPressed: () async {
                                await controller?.pauseCamera();
                              },
                              icon: Icon(
                                Icons.pause_circle_outline,
                                color: Colors.white,
                                size: 50,
                              ))),
                      Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                              onPressed: () async {
                                await controller?.resumeCamera();
                              },
                              icon: Icon(Icons.play_circle_outline_outlined,
                                  color: Colors.white,
                                  size: 50)))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
