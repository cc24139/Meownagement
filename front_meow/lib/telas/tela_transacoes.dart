import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TelaTransacoes extends StatefulWidget {
  const TelaTransacoes({super.key});

  @override
  State<TelaTransacoes> createState() => _TelaTransacoesState();
}

enum OpcoesTransacao { despesa, receita }

final List<String> listaClassificacao = <String>["a", "b", "c", "d"];
final List<String> listaRecorrencia = <String>["aaaa", "Bbbb", "cccc", "dddd"];

class _TelaTransacoesState extends State<TelaTransacoes> {
  OpcoesTransacao? _opcoesTransacao = OpcoesTransacao.despesa;
  TextEditingController _dateController = TextEditingController();

  String dropdownValue = listaClassificacao.first;
  String valorDropdownRecorrencia = listaRecorrencia.first;
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Planeje transações"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "../../assets/icons/vetor_olho_aberto.svg",
                    width: 20,
                    height: 20,
                  ),
                  Text("Saldo"),
                ],
              ),
              Text("Tipo de transação / Data da início"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        RadioListTile<OpcoesTransacao>(
                          title: const Text('Despesa'),
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
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Data da transação',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: "Descrição da transação",
                  border: OutlineInputBorder(),
                ),
              ),

              DropdownButtonFormField<String>(
                isExpanded: true,
                alignment: AlignmentDirectional.center,
                decoration: InputDecoration(
                  labelText: 'Classificação',
                  border: OutlineInputBorder(),
                ),
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: listaClassificacao.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(value, textAlign: TextAlign.center),
                    ),
                  );
                }).toList(),
              ),

              DropdownButtonFormField<String>(
                isExpanded: true,
                alignment: AlignmentDirectional.center,
                decoration: InputDecoration(
                  labelText: 'Recorrência',
                  border: OutlineInputBorder(),
                ),
                value: valorDropdownRecorrencia,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  setState(() {
                    valorDropdownRecorrencia = value!;
                  });
                },
                items: listaRecorrencia.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(value, textAlign: TextAlign.center),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
