
// ignore_for_file: prefer_const_declarations, prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:crypto/database/db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import '../models/criptomoedas.dart';
import 'package:http/http.dart' as http;

class CriptomoedasRepository extends ChangeNotifier {
  List<Criptomoedas> _tabela = [];

  List<Criptomoedas> get tabela => _tabela;

  CriptomoedasRepository() {
    _setupCriptomoedasTable();
    _setupDadosCriptomoedasTable();
    _readCriptomoedasTable();
  }


  //Criar tabela criptomoedas
  _setupCriptomoedasTable() async {
    final String table = '''
      CREATE TABLE IF NOT EXISTS criptomoedas (
        baseId TEXT PRIMARY KEY,
        sigla TEXT,
        nome TEXT,
        icone TEXT,
        valor TEXT
      );
    ''';
    Database db = await DB.instance.database;
    await db.execute(table);
  }

  //Tabela Vazia
  _criptomoedasTableIsEmpty() async {
    Database db = await DB.instance.database;
    List resutados = await db.query('criptomoedas');
    return resutados.isEmpty;
  }

  //Recuperar dados API
  _setupDadosCriptomoedasTable() async {
    if (await _criptomoedasTableIsEmpty()) {
      //API
      String uri = 'https://api.coinbase.com/v2/assets/search?base=BRL';

      final response = await http.get(Uri.parse(uri));

      //CODE 200
      if(response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> criptomoedas = json['data'];
        Database db = await DB.instance.database;
        Batch batch = db.batch();

        criptomoedas.forEach((criptomoeda) {
          final valor = criptomoeda['latest_price'];

          //INSERT
          batch.insert('criptomoedas', {
            'baseId': criptomoeda['id'],
            'sigla': criptomoeda['symbol'],
            'nome': criptomoeda['name'],
            'icone': criptomoeda['image_url'],
            'valor': criptomoeda['latest'],
          });
        });
        await batch.commit(noResult: true);
      }
    }
  }

  //LER TABELA
  _readCriptomoedasTable() async {
    Database db = await DB.instance.database;
    List resultados = await db.query('criptomoedas');

    _tabela = resultados.map((row) {
      return Criptomoedas(
        baseId: row['baseId'],
        sigla: row['sigla'],
        nome: row['nome'],
        icone: row['icone'],
        valor: double.parse(row['valor']),
      );
    }).toList();
    notifyListeners();
  }




}