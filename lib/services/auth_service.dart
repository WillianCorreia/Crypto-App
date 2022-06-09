
// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Erros
class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}

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

  //Recuperar o usuario
  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  //Cadastrar Usuario
  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser(); //Recuperar o usuario
    } on FirebaseAuthException catch (e) {
      if(e.code == 'weak-password') {
        throw AuthException('Senha fraca!');
      } else if(e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado!');
      }
    }
  }

  //Realizar Login
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser(); //Recuperar o usuario
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não cadastrado!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta!');
      }
    }
  }

  //Logout
  logout() async {
    await _auth.signOut();
    _getUser();
  }

}



