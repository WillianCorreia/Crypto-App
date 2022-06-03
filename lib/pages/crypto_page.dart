// ignore_for_file: prefer_const_constructors

import 'package:crypto/models/criptomoedas.dart';
import 'package:crypto/repositories/criptomoedas_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoPage extends StatefulWidget {

  CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final listaCriptomoedas = CriptomoedasRepository.tabela;

  //Formatação do valor
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  List<Criptomoedas> selecionado = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
        child: Text('Crypto Coins'),
        ),
      ),
      body: ListView.separated(
        itemBuilder:(BuildContext context, int criptomoeda) {
          return ListTile(
            leading: (selecionado.contains(listaCriptomoedas[criptomoeda]))
              //Exibir avatar quando selecionado
              ? CircleAvatar(
                  child: Icon(Icons.check),)
              : SizedBox(
                width: 40,
                child: Image.asset(listaCriptomoedas[criptomoeda].icone),),
            //Configuração da Descrição do Item
            title: Text(listaCriptomoedas[criptomoeda].nome,
              style: TextStyle(
                //Configuração da Fonte
                fontWeight: FontWeight.bold,
                fontSize: 17),
            ),
            subtitle: Text(listaCriptomoedas[criptomoeda].sigla),
            trailing: Text(real.format(listaCriptomoedas[criptomoeda].valor)),
            //Configuração Selecionados
            selected: selecionado.contains(listaCriptomoedas[criptomoeda]),
            selectedTileColor: Colors.amber[100],
            selectedColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            onLongPress: () {
              setState(() {
                (selecionado.contains(listaCriptomoedas[criptomoeda]))
                    ? selecionado.remove(listaCriptomoedas[criptomoeda])
                    : selecionado.add(listaCriptomoedas[criptomoeda]);
              });
            },
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_,__) => Divider(),
        itemCount: listaCriptomoedas.length,
      ),

    );


  }
}