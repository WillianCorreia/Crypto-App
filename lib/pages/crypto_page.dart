// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
        child: Text('Crypto Coins'),
        ),
      ),
      body: Center(
        child: Text('Ola'),
      ),
    );


  }
}