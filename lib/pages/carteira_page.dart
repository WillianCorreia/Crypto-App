// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:crypto/models/posicao.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key? key}) : super(key: key);

  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}


class _CarteiraPageState extends State<CarteiraPage> {
  //Inicialização de variáveis
  int index = 0;
  double totalCarteira = 0;
  late double saldo = 0;
  late NumberFormat real;
  late ContaRepository conta;
  List<Posicao> carteira = [];

  @override
  Widget build(BuildContext context) {
    //Recuperar o repositório de contas
    conta = context.watch<ContaRepository>();
    //Formatação de moeda
    real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    //Recupera Saldo
    saldo = conta.saldo;

    setTotalCarteira();

    return Scaffold(
      //HEADER
      appBar: AppBar(
        title: Center(child: Text('Carteira')),
      ),
      //CORPO
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TITULO
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Saldo da Carteira',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

            ),
            //VALOR
            Text(
              real.format(totalCarteira),
              style: TextStyle(fontSize: 32, color: Colors.blue, fontWeight: FontWeight.bold, letterSpacing: -1.5),
            ),
          ],
        ),
      ),
    );
  }

  //Total da Carteira
  setTotalCarteira(){
    final carteiraList = conta.carteira;
    setState(() {
      totalCarteira = conta.saldo;
      for (var posicao in carteiraList) {
        totalCarteira += posicao.criptomoeda.valor * posicao.quantidade;
      }
    });

  }

}