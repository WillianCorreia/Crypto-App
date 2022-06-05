// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_const_constructors

import 'package:crypto/models/criptomoedas.dart';
import 'package:crypto/pages/crypto_detalhes_page.dart';
import 'package:crypto/repositories/favoritos_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CriptomoedasCard extends StatefulWidget {
  Criptomoedas cryptomoedas;

  CriptomoedasCard({Key? key, required this.cryptomoedas}) : super(key: key);

  @override
  _CriptomoedasCardState createState() => _CriptomoedasCardState();
}

class _CriptomoedasCardState extends State<CriptomoedasCard> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> valorColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CryptoDetalhesPage(criptomoeda: widget.cryptomoedas),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.cryptomoedas.icone,
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cryptomoedas.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.cryptomoedas.sigla,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: valorColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: valorColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.cryptomoedas.valor),
                  style: TextStyle(
                    fontSize: 16,
                    color: valorColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Remover dos Favoritos'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<FavoritosRepository>(context, listen: false)
                            .remove(widget.cryptomoedas);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}