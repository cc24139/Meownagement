import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaTransacoes extends StatefulWidget {
  const TelaTransacoes({super.key});

  @override
  State<TelaTransacoes> createState() => _TelaTransacoesState();
}

enum OpcoesTransacao { despesa, receita }


class _TelaTransacoesState extends State<TelaTransacoes> {
  OpcoesTransacao? _opcoesTransacao = OpcoesTransacao.despesa;
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),  
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Planeje transações"),
            Row(
              children: [
                SvgPicture.asset("../../assets/icons/vetor_olho_aberto.svg"),
                Text("Saldo")
              ],
            ),
            Text("Tipo de transação / Data da início"),
            Column(
              children: <Widget> [
                RadioListTile<OpcoesTransacao>(
                  title: const Text('Despesa'), // The label for the radio button
                  value: OpcoesTransacao.despesa,
                  groupValue: _opcoesTransacao,
                  onChanged: (OpcoesTransacao? value) {
                    setState(() {
                      _opcoesTransacao = value;
                    });
                  },
                ),
                RadioListTile<OpcoesTransacao>(
                  title: const Text("Receita"),
                  value: OpcoesTransacao.receita,
                  groupValue: _opcoesTransacao,
                  onChanged: (OpcoesTransacao? value) {
                    setState(() {
                      _opcoesTransacao = value;
                    });
                  },
                ),
              ],
            ),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Select Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context),
            ),
          ],
        ),
      ),
      
    );
  }
}
