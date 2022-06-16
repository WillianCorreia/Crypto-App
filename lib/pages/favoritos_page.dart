// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:crypto/repositories/favoritos_repository.dart';
import 'package:crypto/widget/criptomoedas_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  FavoritosPage({Key? key}) : super(key: key);

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //HEADER
      appBar: AppBar(
        title: Center(child: Text('Favoritos')),
      ),
      //CORPO
      body: Container(
        color: Colors.grey.withOpacity(0.3),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        //Consumir Favoritos
        child: Consumer<FavoritosRepository>(
          builder: (context, favoritos, child) {
            return favoritos.lista.isEmpty
                //Se Favoritos Vazio
                ? ListTile(
                  leading: Icon(Icons.highlight_off, color: Colors.black, size: 30,),
                  title: Text('Não há criptomoedas favoritas',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                  ))
                //Se Favoritos Preenchido
                : ListView.builder(
                  itemCount: favoritos.lista.length,
                  itemBuilder: (_, index) {
                    return CriptomoedasCard(cryptomoedas: favoritos.lista[index],);
                  },
                );
          }
        ),
      ),
    );
  }

}