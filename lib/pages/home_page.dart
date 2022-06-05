// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:crypto/pages/crypto_page.dart';
import 'package:crypto/pages/favoritos_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: PageView(
          controller: PageController,
          children: [
            CryptoPage(),
            FavoritosPage(),
          ],
        ),
      );
    }
  }
