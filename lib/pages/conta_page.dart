// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto/repositories/conta_repository.dart';
import 'package:crypto/services/auth_service.dart';
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
        title: Center(child: Text('Minha Conta')),
      ),
      //CORPO
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              //TITULO
              title: Text('Saldo'),
              //SALDO
              subtitle: Text(
                  real.format(conta.saldo),
                  style: TextStyle(fontSize: 25, color: Colors.indigoAccent, fontWeight: FontWeight.w500)
              ),
              //ICONE
              trailing: IconButton(onPressed: updateSaldo, icon: Icon(Icons.edit, color: Colors.black,),),
            ),
            Divider(color: Colors.black,),
            //SAIR
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: OutlinedButton(
                onPressed: () => context.read<AuthService>().logout(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  primary: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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