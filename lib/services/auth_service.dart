
// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //Instancia do FirebaseAuth
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  //Inicializacao do Login
  AuthService() {
    _authCheck();
  }

  //Verifica se o usuario esta logado
  _authCheck() {
    //Ouvir se o usuario esta logado
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }


}