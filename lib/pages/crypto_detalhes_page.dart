// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:crypto/models/criptomoedas.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CryptoDetalhesPage extends StatefulWidget {
  Criptomoedas criptomoeda;
  CryptoDetalhesPage({Key? key, required this.criptomoeda}) : super(key: key);

  @override
  _CryptoDetalhesPageState createState() => _CryptoDetalhesPageState();
}

class _CryptoDetalhesPageState extends State<CryptoDetalhesPage> {
  //Formatação de moeda
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  double quantidade = 0;
  //Identificador Formulario
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  late ContaRepository conta;

  //SIMULAR
  simular() async {
    if(_formKey.currentState!.validate()){
      //Retornar para tela anterior
      Navigator.pop(context);
      //Mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Compra realizada com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    conta = Provider.of<ContaRepository>(context, listen: false);
    return Scaffold(
      //HEADER
      appBar: AppBar(
        title: Text(widget.criptomoeda.nome),
      ),
      //BODY
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(widget.criptomoeda.icone),
                    width: 40,
                  ),
                  Container(width: 20),
                  Text(
                    real.format(widget.criptomoeda.valor),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.black,
                    ),)],
              ),
            ),
            //CAMPO CONVERTER
            (quantidade > 0)
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Text(
                  '$quantidade ${widget.criptomoeda.sigla}',
                  style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  )
                ),
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            )
            : Container(
              margin: EdgeInsets.only(bottom: 24),
            ),
            //FORMULARIO
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _valorController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor de Compra',
                  prefixIcon: Icon(Icons.currency_exchange, color: Colors.black, size: 20,),
                  suffix: Text('reais', style: TextStyle(fontSize: 16, color: Colors.black),),
                  ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) > conta.saldo) {
                    return 'Saldo Insuficiente';
                  }
                  return null;
                },
                //CALCULAR QUANTIDADE
                  onChanged: (value) {
                  setState(() {
                    quantidade = double.parse(value) / widget.criptomoeda.valor;
                  });
                },
              ),
            ),
            //BOTAO SIMULAR
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: simular,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Simulação de Compra', style: TextStyle(fontSize: 18)),
                    Container(width: 5),
                  ],

                ),
                ),
            ),
        ],),
      ),
    );
  }
}