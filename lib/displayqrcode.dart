import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQRCode extends StatefulWidget {
  final String? data;
  final double styleQRSize;

  const DisplayQRCode({
    Key? key,
    required this.data,
    this.styleQRSize = 100,
  }) : super(key: key);

  @override
  _DisplayQRCodeState createState() => _DisplayQRCodeState();
}

class _DisplayQRCodeState extends State<DisplayQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: widget.styleQRSize,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("QR Code"),
            QrImage(
              data: widget.data!,
              version: QrVersions.auto,
              size: widget.styleQRSize,
              gapless: true,
              backgroundColor: Colors.white,
            )
          ]),
    );
  }
}
