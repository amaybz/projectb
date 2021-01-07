import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:projectb/localdb.dart';

class DisplayQRCode extends StatefulWidget {
  final MatchScoutingData match;
  final double styleQRSize;

  const DisplayQRCode({
    Key key,
    @required this.match,
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
          data: widget.match.toString(),
          version: QrVersions.auto,
          size: widget.styleQRSize,
          gapless: false,
        )
      ]),
    );
  }
}
