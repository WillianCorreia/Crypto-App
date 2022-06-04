// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:crypto/models/criptomoedas.dart';
import 'package:flutter/material.dart';

class CryptoDetalhesPage extends StatefulWidget {
  Criptomoedas criptomoeda;
  CryptoDetalhesPage({Key? key, required this.criptomoeda}) : super(key: key);

  @override
  _CryptoDetalhesPageState createState() => _CryptoDetalhesPageState();
}

class _CryptoDetalhesPageState extends State<CryptoDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.criptomoeda.nome),
      ),
      body: Center(
        child: Text('Detalhes'),
      ),
    );
  }
}