// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:crypto/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toogleButton;
  bool loading = false;


  //Inicializar o estado
  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  //Setar o formulario
  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      //Login
      if(isLogin) {
        titulo = 'Bem Vindo';
        actionButton = 'Login';
        toogleButton = 'Ainda não tem conta ? Cadastre-se agora.';
      //Cadastro
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toogleButton = 'Voltar ao Login.';
      }
    });

  }
  //Realizar Login
  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.mensagem),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //Cadastrar Usuario
  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.mensagem),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TITULO
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                //EMAIL
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                      if(value!.isEmpty) {
                        return 'Informar o e-mail';
                      }
                      return null;
                  },
                  ),
                ),
                //SENHA
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Informar a senha';
                      } else if(value.length < 6) {
                        return 'Sua senha deve possuir no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                //BOTAO
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () {
                      //Ação do botão
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                      ? [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ]
                      : [
                          Icon(Icons.check),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              actionButton,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
                //TOGGLE
                TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(toogleButton)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}