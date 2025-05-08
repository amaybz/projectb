import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        final values = scannedBarcodes.map((e) => e.displayValue).join(', ');

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan!',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        return Text(
          values.isEmpty ? 'No display value.' : values,
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
