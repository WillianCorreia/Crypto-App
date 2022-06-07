// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:crypto/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ContaPage extends StatefulWidget {
  ContaPage({Key? key}) : super(key: key);

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  @override
  Widget build(BuildContext context) {
    //Recuperar o Repositorio Conta
    final conta = context.watch<ContaRepository>();
    //Formatar o valor
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

    return Scaffold(
      //HEADER
      appBar: AppBar(
        title: Center(child: Text('Conta')),
      ),
      //CORPO
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            //Saldo
            ListTile(
              title: Text('Saldo'),
              subtitle: Text(
                  real.format(conta.saldo),
                  style: TextStyle(fontSize: 25, color: Colors.indigo)
              ),
              trailing: IconButton(onPressed: updateSaldo, icon: Icon(Icons.edit),),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  //Atualizar Saldo
  updateSaldo() async {
    //Formulario
    final form = GlobalKey<FormState>();
    //TextField
    final valor = TextEditingController();
    //Conta Repositorio
    final conta = context.read<ContaRepository>();

    //Recuperar valor
    valor.text = conta.saldo.toString();

    //Criar Alerta
    AlertDialog alerta = AlertDialog(
      title: Text('Atualizar Saldo'),
      content: Form(
        key: form,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),],
          validator: (value) {
            if(value!.isEmpty){
              return 'Informe o valor do saldo';
            }
            return null;
          },
        ),
      ),
      actions: [
        //Cancelar
        TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCELAR')),
        //Salvar
        TextButton(onPressed: () {
          if (form.currentState!.validate()){
            //Atualizar Saldo
            conta.setSaldo(double.parse(valor.text));
            //Fechar Alerta
            Navigator.pop(context);
          }
        }, child: Text('SALVAR')),

      ],
    );

    //Exibir Alerta
    showDialog(context: context, builder: (_) => alerta);
  }

}