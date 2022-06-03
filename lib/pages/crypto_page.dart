// ignore_for_file: prefer_const_constructors

import 'package:crypto/repositories/criptomoedas_repository.dart';
import 'package:flutter/material.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaCriptomoedas = CriptomoedasRepository.tabela;

    return Scaffold(
      appBar: AppBar(
        title: Center(
        child: Text('Crypto Coins'),
        ),
      ),
      body: ListView.separated(
        itemBuilder:(BuildContext context, int cripto) {
          return ListTile(
            leading: Image.asset(listaCriptomoedas[cripto].icone),
            title: Text(listaCriptomoedas[cripto].nome),
            subtitle: Text(listaCriptomoedas[cripto].sigla),
            trailing: Text(listaCriptomoedas[cripto].valor),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_,__) => Divider(),
        itemCount: listaCriptomoedas.length,
      ),

    );


  }
}