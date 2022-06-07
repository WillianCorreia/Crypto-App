// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:crypto/models/posicao.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
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

  String graficoLabel = "";
  double graficoValor = 0;
  List<Posicao> carteira = [];

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
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
            //Titulo
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Valor da Carteira
            Text(
              real.format(totalCarteira),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: -1.5),
            ),
            //Grafico
            loadGrafico(),
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

  setGraficoDados(index){
    if(index < 0) return;

    if(index == carteira.length){
      graficoLabel = "Saldo";
      graficoValor = conta.saldo;
    } else {
      graficoLabel = carteira[index].criptomoeda.nome;
      graficoValor = carteira[index].criptomoeda.valor * carteira[index].quantidade;
    }
  }

  //Carregar Carteira
  loadCarteira() {
    setGraficoDados(index);
    carteira = conta.carteira;
    final tamanhoLista = carteira.length + 1;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista - 1;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];

      double porcentagem = 0;
      if(!isSaldo) {
        porcentagem = (carteira[i].criptomoeda.valor * carteira[i].quantidade) / totalCarteira;
      } else {
        porcentagem = (conta.saldo > 0) ? conta.saldo / totalCarteira : 0;
      }
      porcentagem = porcentagem * 100;

      return PieChartSectionData(
        color: color,
        value: porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    });
  }

  //Grafico
  loadGrafico() {
    return (conta.saldo <= 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 5,
                    centerSpaceRadius: 110,
                    sections: loadCarteira(),
                    pieTouchData: PieTouchData(
                      touchCallback: (touch) => setState(() {
                        index = touch.touchedSection!.touchedSectionIndex;
                        setGraficoDados(index);
                      }),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                  Text(
                    real.format(graficoValor),
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              )
            ],
    );
  }


}