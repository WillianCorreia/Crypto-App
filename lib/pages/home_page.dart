// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:crypto/pages/carteira_page.dart';
import 'package:crypto/pages/conta_page.dart';
import 'package:crypto/pages/crypto_page.dart';
import 'package:crypto/pages/favoritos_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pageController;

  //Inicializar o estado
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        //BODY
        body: PageView(
          controller: pageController,
          //Adicionar as páginas
          children: [
            CryptoPage(), //Home
            FavoritosPage(), //Favoritos
            CarteiraPage(), //Carteira
            ContaPage(), //Conta
          ],
          onPageChanged: setPaginaAtual,
        ),
        //Botao de Menu
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          //Botao Fixo
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Carteira'),
            BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: 'Conta'),
          ],
          //Efeito do botão
          onTap: (pagina) {
            pageController.animateToPage(
              pagina,
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            );
          },
          backgroundColor: Colors.grey[200],
        ),
      );
    }

  }
