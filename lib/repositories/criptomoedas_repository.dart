import 'package:flutter/material.dart';

import '../models/criptomoedas.dart';

class CriptomoedasRepository{
  static List<Criptomoedas> tabela = [
    Criptomoedas(
      icone: 'images/bitcoin.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      valor: 144270.00,
    ),
    Criptomoedas(
      icone: 'images/cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      valor: 2.70,
    ),
    Criptomoedas(
      icone: 'images/ethereum.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      valor: 8780.00,
    ),
    Criptomoedas(
      icone: 'images/litecoin.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      valor: 303.90,
    ),
    Criptomoedas(
      icone: 'images/usdcoin.png',
      nome: 'USD Coin',
      sigla: 'USDC',
      valor: 4.80,
    ),
    Criptomoedas(
      icone: 'images/xrp.png',
      nome: 'XRP',
      sigla: 'XRP',
      valor: 1.90,
    ),
  ];



}