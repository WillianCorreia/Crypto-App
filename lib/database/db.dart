// ignore_for_file: depend_on_referenced_packages


import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  //Construtor com acesso privado
  DB._();
  //Criar instancia DB
  static final DB instance = DB._();
  //Instancia SQLite
  static Database? _database;

  //Acesso ao DB
  get database async {
    if (_database != null) return _database;

    return await _initDB();
  }

  //Inicializar DB
  _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'crypto.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  //Criar tabela
  _onCreate(db, versao) async {
    await db.execute(_conta);
    await db.execute(_carteira);
    await db.execute(_historico);
    await db.insert('conta',{'saldo': 0});
  }

  //Criar tabela conta
  String get _conta => '''
    CREATE TABLE conta (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      saldo REAL
    );
  ''';

  //Criar tabela carteira
  String get _carteira => '''
    CREATE TABLE carteira (
      sigla TEXT PRIMARY KEY,
      criptomoeda TEXT,
      quantidade TEXT
    );
  ''';

  //Criar tabela historico
  String get _historico => '''
    CREATE TABLE historico (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_operacao INT,
      tipo_operacao TEXT,
      criptomoeda TEXT,
      sigla TEXT,
      valor REAL,
      quantidade TEXT
    );
  ''';
}