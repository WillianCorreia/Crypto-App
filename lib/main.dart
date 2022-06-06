// ignore_for_file: prefer_const_constructors

import 'package:crypto/crypto_app.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:crypto/repositories/favoritos_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => FavoritosRepository()),
      ],
      child: CryptoApp(),
    ),
  );
}








