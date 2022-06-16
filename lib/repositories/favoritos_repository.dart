// ignore_for_file: prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'dart:collection';
import 'package:crypto/models/criptomoedas.dart';
import 'package:flutter/material.dart';

class FavoritosRepository extends ChangeNotifier {
  //Criar Lista Vazia
  List<Criptomoedas> _lista = [];
  //Metodo GET para lista
  UnmodifiableListView<Criptomoedas> get lista => UnmodifiableListView(_lista);

  //Salvar Criptomoedas Selecionadas
  saveAll(List<Criptomoedas> criptomoedas) {
    criptomoedas.forEach((criptomoedas) {
      if (!_lista.contains(criptomoedas)) _lista.add(criptomoedas);
    });
    //Notificar que houve alteração
    notifyListeners();
  }

  //Remover Criptomoedas Selecionadas
  remove(Criptomoedas criptomoedas) {
    _lista.remove(criptomoedas);
    //Notificar que houve alteração
    notifyListeners();
  }


}

