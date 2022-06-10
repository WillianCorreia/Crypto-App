
// ignore_for_file: prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'package:crypto/database/db.dart';
import 'package:crypto/models/criptomoedas.dart';
import 'package:crypto/models/posicao.dart';
import 'package:crypto/repositories/criptomoedas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;

  //Construtor
  ContaRepository() {
    _initRepository();
  }

  //Inicializar repositorio
  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
  }

  //RECUPERAR SALDO
  _getSaldo() async {
    db = await DB.instance.database;
      List conta = await db.query('conta', limit: 1);
      _saldo = conta.first['saldo'];
      notifyListeners();
  }

  //ATUALIZAR SALDO
  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  //COMPRAR
  comprar(Criptomoedas criptomoedas, double valor) async {
    db = await DB.instance.database;
    await db.transaction((txn) async {
      //Verificar se ja foi comprada
      final posicao = await txn.query('carteira', where: 'sigla = ?', whereArgs: [criptomoedas.sigla]);
      //Se nao foi comprada
      if (posicao.isEmpty) {
        await txn.insert('carteira', {
          'sigla': criptomoedas.sigla,
          'criptomoeda': criptomoedas.nome,
          'quantidade': (valor / criptomoedas.valor).toString(),
        });
      //Se ja foi comprada
      } else {
        final atual = double.parse(posicao.first['quantidade'].toString());
        await txn.update('carteira', {
         'quantidade': ((valor / criptomoedas.valor) + atual).toString(),
          }, where: 'sigla = ?', whereArgs: [criptomoedas.sigla]
        );
      }

      //Atualizar Historico
      await txn.insert('historico', {
        'sigla': criptomoedas.sigla,
        'criptomoeda': criptomoedas.nome,
        'quantidade': (valor / criptomoedas.valor).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch,
      });

      //Atualizar saldo
      await txn.update('conta', {
        'saldo': saldo - valor,
      });

      await _initRepository();
      notifyListeners();
    });
  }

  //ATUALIZAR CARTEIRA
  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Criptomoedas criptomoedas = CriptomoedasRepository.tabela.firstWhere(
          (m) => m.sigla == posicao['sigla'],
      );
      _carteira.add(Posicao(
        criptomoeda: criptomoedas,
        quantidade: double.parse(posicao['quantidade']),
      ));
    });
    notifyListeners();

  }


}