// ignore_for_file: prefer_const_constructors

import 'package:crypto/crypto_app.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:crypto/repositories/favoritos_repository.dart';
import 'package:crypto/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  //Executado antes do app iniciar
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa o Firebase
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()), //Autenticação
        ChangeNotifierProvider(create: (context) => ContaRepository()), //Menu Conta
        ChangeNotifierProvider(create: (context) => FavoritosRepository()), //Menu Favoritos
      ],
      child: CryptoApp(),
    ),
  );
}








