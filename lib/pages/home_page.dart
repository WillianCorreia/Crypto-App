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
        body: PageView(
          controller: pageController,
          children: [
            CryptoPage(),
            FavoritosPage(),
            CarteiraPage(),
            ContaPage(),
          ],
          onPageChanged: setPaginaAtual,
        ),
        //Botao Todas e Favoritos
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          //Botoes Fixos
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Carteira'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
          ],
          //Efeito do botão Todas e Favoritos
          onTap: (pagina) {
            pageController.animateToPage(
              pagina,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          backgroundColor: Colors.grey[200],
        ),
      );
    }
  }
