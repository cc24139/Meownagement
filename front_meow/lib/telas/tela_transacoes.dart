import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/TitleTelaWidget.dart';
import 'package:front_meow/Widgets/VerticalSelectWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:intl/intl.dart';
import 'package:front_meow/Widgets/textfieldInputDinheiro.dart'; 

class TelaTransacoes extends StatefulWidget {
  const TelaTransacoes({super.key});

  @override
  State<TelaTransacoes> createState() => _TelaTransacoesState();
}

enum OpcoesTransacao { despesa, receita }

final List<String> listaClassificacao = <String>["a", "b", "c", "d"];
final List<String> listaRecorrencia = <String>["aaaa", "Bbbb", "cccc", "dddd"];

void _cancelar(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

void _salvar(BuildContext context) {
  //TODO salvar na api os dados
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

class _TelaTransacoesState extends State<TelaTransacoes> {
  OpcoesTransacao? _opcoesTransacao = OpcoesTransacao.despesa;
  final TextEditingController _dateController = TextEditingController();
  final _valorController = CurrencyInputController(initialValue: 0.0);

  String dropdownValue = listaClassificacao.first;
  String valorDropdownRecorrencia = listaRecorrencia.first;
  CatColors cores = CatColors(paleta: 4);
  
  @override
  void dispose() {
    _dateController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _trocar() {
    //Trocar icone e texto
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              onPressed: () => Scaffold.of(context).openDrawer(),
                              icon: Icon(Icons.menu, color: cores.complementar, size: 25),
                            ),
                          ),
                          Expanded(
                            child: TitleTelaWidget(
                              title: "Planeje transações",
                              subtitle: "",
                              catColors: cores,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _trocar,
                            icon: Icon(Icons.visibility_off, color: cores.complementar, size: 25),
                          ),
                          Text("Saldo", style: TextStyle(color: cores.complementar)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text("Valor da transação", style: TextStyle(color: cores.secundaria, fontSize: 16)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: cores.secundaria, fontSize: 24, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: cores.corTerciaria, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: cores.corTerciaria, width: 4.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("Tipo de transação", style: TextStyle(color: cores.corSecundaria, fontSize: 16)),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Verticalselectwidget<OpcoesTransacao>(
                                      label: 'Despesa',
                                      value: OpcoesTransacao.despesa,
                                      groupValue: _opcoesTransacao,
                                      cores: cores,
                                      onChanged: (value) => setState(() => _opcoesTransacao = value),
                                    ),
                                    Verticalselectwidget<OpcoesTransacao>(
                                      label: 'Receita',
                                      value: OpcoesTransacao.receita,
                                      groupValue: _opcoesTransacao,
                                      cores: cores,
                                      onChanged: (value) => setState(() => _opcoesTransacao = value),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                Text("Data de início", style: TextStyle(color: cores.corSecundaria, fontSize: 16)),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
                                  style: TextStyle(color: cores.complementar),
                                  decoration: InputDecoration(
                                    labelText: 'Data da transação',
                                    labelStyle: TextStyle(color: cores.complementar),
                                    suffixIcon: Icon(Icons.calendar_today, color: cores.complementar),
                                  ),
                                  onTap: () => _selectDate(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 3,
                        maxLength: 150,
                        decoration: InputDecoration(
                          hintText: "Descrição da transação",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                               width: 2
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 4
                            )
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Classificação", style: TextStyle(color: cores.secundaria, fontSize: 16)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        alignment: AlignmentDirectional.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: cores.corTerciaria, width: 2)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: cores.corTerciaria, width: 2)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) => setState(() => dropdownValue = value!),
                        items: listaClassificacao.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text("Recorrência", style: TextStyle(color: cores.secundaria, fontSize: 16)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        alignment: AlignmentDirectional.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: cores.corTerciaria, width: 2)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: cores.corTerciaria, width: 2)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        value: valorDropdownRecorrencia,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) => setState(() => valorDropdownRecorrencia = value!),
                        items: listaRecorrencia.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16), 
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        backgroundColor: cores.corTerciaria,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => _cancelar(context),
                      child: Text("Cancelar", style: TextStyle(color: cores.complementar, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        backgroundColor: cores.corSecundaria,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => _salvar(context),
                      child: Text("Efetuar", style: TextStyle(color: cores.complementar, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: cores.primaria,
      drawer: Menulateralwidget(),
    );
  }
}