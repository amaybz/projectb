import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:projectb/localdb.dart';

class DisplayQRCode extends StatefulWidget {
  final String matchID;
  final double styleQRSize;

  const DisplayQRCode({
    Key key,
    @required this.matchID,
    this.styleQRSize = 100,
  }) : super(key: key);

  @override
  _DisplayQRCodeState createState() => _DisplayQRCodeState();
}

class _DisplayQRCodeState extends State<DisplayQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        //Text("QR Code"),
        QrImage(
          data: "{matchID: " + widget.matchID + '}',
          version: QrVersions.auto,
          size: widget.styleQRSize,
          gapless: false,
        )
      ]),
    );
  }
}
