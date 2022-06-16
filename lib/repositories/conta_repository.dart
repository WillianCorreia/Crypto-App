
// ignore_for_file: prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'package:crypto/database/db.dart';
import 'package:crypto/models/posicao.dart';
import 'package:crypto/repositories/criptomoedas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  double _saldo = 0;
  CriptomoedasRepository criptomoedas;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;

  //Construtor
  ContaRepository({required this.criptomoedas}) {
    _initRepository();
  }

  //Inicializar repositorio
  _initRepository() async {
    await _getSaldo();

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

}