import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/TitleTelaWidget.dart';
import 'package:front_meow/Widgets/VerticalSelectWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/Widgets/textfieldInputDinheiro.dart';
import 'package:localstorage/localstorage.dart';

class TelaGaveta extends StatefulWidget {
  const TelaGaveta({super.key});

  @override
  State<TelaGaveta> createState() => _TelaGavetaState();
}

enum OpcoesRecorrencia { semanal, mensal, anual }

void _cancelar(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

void _salvar(BuildContext context) {
  //TODO salvar na api os dados
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

class _TelaGavetaState extends State<TelaGaveta> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  OpcoesRecorrencia? _opcoesRecorrencia = OpcoesRecorrencia.semanal;
  final _valorMeta = CurrencyInputController(initialValue: 0.0);
  final _nomeMeta = TextEditingController();
  final _duracaoMeta = TextEditingController();

  CatColors cores = CatColors(paleta: int.parse( localStorage.getItem('paleta') ?? '1'));

  @override
  void dispose() {
    _valorMeta.dispose();
    _nomeMeta.dispose();
    _duracaoMeta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _getSuffixText() {
      switch (_opcoesRecorrencia) {
        case OpcoesRecorrencia.semanal:
          return ' Semanas: ';
        case OpcoesRecorrencia.mensal:
          return ' Meses: ';
        case OpcoesRecorrencia.anual:
          return ' Anos: ';
        default:
          return ' Semanas: ';
      }
    }

    return Scaffold(
      key: _scaffoldKey,
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
                              onPressed: () =>
                                  _scaffoldKey.currentState?.openDrawer(),
                              icon: Icon(
                                Icons.menu,
                                color: cores.complementar,
                                size: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TitleTelaWidget(
                              titulo: "Guarde na Gaveta",
                              tamanho: 50,
                              qtsBolas: 11,
                              overlapFactor: 0.45,
                              tamanhoFonte: 38.0,
                              cores: CatColors(paleta: int.parse( localStorage.getItem('paleta') ?? '1')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                      Text(
                        "Nome da meta",
                        style: TextStyle(color: cores.secundaria, fontSize: 20),
                      ),
                      TextField(
                        controller: _nomeMeta,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: cores.secundaria, fontSize: 16),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Valor para economizar",
                        style: TextStyle(color: cores.secundaria, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _valorMeta,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cores.secundaria,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 4.0,
                            ),
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
                                Text(
                                  "Tipo de transação",
                                  style: TextStyle(
                                    color: cores.corSecundaria,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Verticalselectwidget<OpcoesRecorrencia>(
                                      label: 'Semanal',
                                      value: OpcoesRecorrencia.semanal,
                                      groupValue: _opcoesRecorrencia,
                                      cores: cores,
                                      onChanged: (value) => setState(
                                        () => _opcoesRecorrencia = value,
                                      ),
                                    ),
                                    Verticalselectwidget<OpcoesRecorrencia>(
                                      label: 'Mensal',
                                      value: OpcoesRecorrencia.mensal,
                                      groupValue: _opcoesRecorrencia,
                                      cores: cores,
                                      onChanged: (value) => setState(
                                        () => _opcoesRecorrencia = value,
                                      ),
                                    ),
                                    Verticalselectwidget<OpcoesRecorrencia>(
                                      label: 'Anual',
                                      value: OpcoesRecorrencia.anual,
                                      groupValue: _opcoesRecorrencia,
                                      cores: cores,
                                      onChanged: (value) => setState(
                                        () => _opcoesRecorrencia = value,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Duração",
                        style: TextStyle(color: cores.secundaria, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _duracaoMeta,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        style: TextStyle(color: cores.secundaria, fontSize: 20),
                        decoration: InputDecoration(
                          prefix: Text(
                            _getSuffixText(),
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 20,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 3.0,
                            ),
                          ),
                        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _cancelar(context),
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        backgroundColor: cores.corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _salvar(context),
                      child: Text(
                        "Criar",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 18,
                        ),
                      ),
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
