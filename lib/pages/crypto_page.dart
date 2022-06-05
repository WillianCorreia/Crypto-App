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
  final listaCriptomoedas = CriptomoedasRepository.tabela;
  //Formatação do valor
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Criptomoedas> selecionado = [];
  late FavoritosRepository favoritos;



  appBarDinamica() {
    if(selecionado.isEmpty) {
      return AppBar( //Nada Selecionado
        title: Center(child: Text('Criptomoedas')));
    } else {
      return AppBar( //Item Selecionado
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            setState(() {
              selecionado = [];
            });},),
        title: Center(child: Text('${selecionado.length} selecionados'),),
        backgroundColor: Colors.grey[500],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
  //Direcionar para pagina de Detalhe
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
    //Favoritos
    favoritos = Provider.of<FavoritosRepository>(context);

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
            //Configuração da Descrição do Item
            title: Row(
              children: [
                Text(
                  listaCriptomoedas[criptomoeda].nome,
                  style: TextStyle(
                    //Configuração da fonte
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Exibir icone de favorito quando favorito
                if (favoritos.lista.contains(listaCriptomoedas[criptomoeda]))
                  Icon(Icons.star, color: Colors.blue, size: 12,),
              ],
            ),
            subtitle: Text(listaCriptomoedas[criptomoeda].sigla),
            trailing: Text(real.format(listaCriptomoedas[criptomoeda].valor)),
            //Configuração Selecionados
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
            //Detalhar Criptomoeda
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