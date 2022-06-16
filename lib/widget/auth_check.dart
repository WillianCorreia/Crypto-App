// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:crypto/pages/home_page.dart';
import 'package:crypto/pages/login_page.dart';
import 'package:crypto/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    //Ouvir se o usuario esta logado
    if (auth.isLoading) {
      return loading(); //Tela de carregamento
    } else if (auth.usuario == null) {
      return LoginPage(); //Pagina de login
    } else {
      return HomePage(); //Pagina inicial
    }
  }

  //Tela de carregamento
  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}