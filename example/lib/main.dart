// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: FlutterLoginDemo(),
    ),
  );
}

class FlutterLoginDemo extends StatelessWidget {
  const FlutterLoginDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('FlutterLoginDemo'));
  }
}
