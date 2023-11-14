import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(
          onPressed: scanCheque, icon: const Icon(Icons.qr_code_scanner)),
      IconButton(
          onPressed: openCameraAndScanText,
          icon: const Icon(Icons.document_scanner))
    ];

    return Scaffold(
      appBar: AppBar(
        actions: actions,
      ),
      body: Container(),
    );
  }

  void scanCheque() {}

  void openCameraAndScanText() {}

  void parseText() {}
}
