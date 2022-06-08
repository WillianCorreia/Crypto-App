// ignore_for_file: prefer_const_constructors

import 'package:crypto/pages/crypto_page.dart';
import 'package:crypto/pages/home_page.dart';
import 'package:crypto/widget/auth_check.dart';
import 'package:flutter/material.dart';

class CryptoApp extends StatelessWidget {
  const CryptoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AuthCheck(),
    );
  }
}