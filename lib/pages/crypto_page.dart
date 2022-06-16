// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:crypto/models/criptomoedas.dart';
import 'package:crypto/pages/crypto_detalhes_page.dart';
import 'package:crypto/repositories/criptomoedas_repository.dart';
import 'package:crypto/repositories/favoritos_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CryptoPage extends StatefulWidget {
  CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  //Repositório de Criptomoedas
  final listaCriptomoedas = CriptomoedasRepository.tabela;
  //Formatação do valor
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Criptomoedas> selecionado = [];
  late FavoritosRepository favoritos;



  appBarDinamica() {
    if(selecionado.isEmpty) {
      //NADA SELECIONADO
      return AppBar(
        title: Center(child: Text('Criptomoedas')));
    } else {
      //SELECIONADO
      return AppBar(
        //HEADER SELECIONADO
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            setState(() {
              selecionado = [];
            });},),
        title: Center(child: Text('${selecionado.length} selecionados'),),
        backgroundColor: Colors.grey[600],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  //Detahe de criptomoeda
  detalharCrypto (Criptomoedas criptomoeda) {
     Navigator.push(context, MaterialPageRoute(
         builder: (_) => CryptoDetalhesPage(criptomoeda: criptomoeda)));

  }

  //Limpar Selecionado
  limparSelecionado() {
    setState(() {
      selecionado = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Repositório de Favoritos
    favoritos = Provider.of<FavoritosRepository>(context);

    //FAVORITAR
    return Scaffold(
      appBar: appBarDinamica(),
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
            //Descrição do Item
            title: Row(
              children: [
                Text(
                  //Nome da criptomoeda
                  listaCriptomoedas[criptomoeda].nome,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Icone de favorito
                if (favoritos.lista.contains(listaCriptomoedas[criptomoeda]))
                  Icon(Icons.star, color: Colors.amber, size: 14),
              ],
            ),
            //Sigla da criptomoeda
            subtitle: Text(listaCriptomoedas[criptomoeda].sigla),
            //Valor da criptomoeda
            trailing: Text(real.format(listaCriptomoedas[criptomoeda].valor)),
            //Criptomoeda Selecionada
            selected: selecionado.contains(listaCriptomoedas[criptomoeda]),
            selectedTileColor: Colors.indigoAccent[100],
            selectedColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            //Selecionar para Favoritar
            onLongPress: () {
              setState(() {
                (selecionado.contains(listaCriptomoedas[criptomoeda]))
                    ? selecionado.remove(listaCriptomoedas[criptomoeda])
                    : selecionado.add(listaCriptomoedas[criptomoeda]);
              });
            },
            //DETALHAR CRIPTOMOEDA
            onTap: () => detalharCrypto(listaCriptomoedas[criptomoeda]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_,__) => Divider(),
        itemCount: listaCriptomoedas.length,
      ),
      //Botão Favorito
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionado.isNotEmpty
        ? FloatingActionButton.extended(
            onPressed: (){
              favoritos.saveAll(selecionado);
              limparSelecionado();
            },
            icon: Icon(Icons.star),
            label: Text('Favoritar',
              style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ))
        : null,
    );


  }
}