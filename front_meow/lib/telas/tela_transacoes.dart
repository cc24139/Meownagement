import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/TitleTelaWidget.dart';
import 'package:front_meow/Widgets/VerticalSelectWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/classificacao.dart';
import 'package:front_meow/models/Meta.dart';
import 'package:front_meow/models/Cofrinho.dart';
import 'package:front_meow/models/recorrencia.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/MetaServices.dart';
import 'package:front_meow/services/CofrinhoServices.dart';
import 'package:front_meow/services/TransacaoServices.dart';
import 'package:intl/intl.dart';
import 'package:front_meow/Widgets/textfieldInputDinheiro.dart';
import 'package:localstorage/localstorage.dart';
import 'package:front_meow/services/RecorrenciaServices.dart';

class TelaTransacoes extends StatefulWidget {
  const TelaTransacoes({super.key});

  @override
  State<TelaTransacoes> createState() => _TelaTransacoesState();
}

enum OpcoesTransacao { despesa, receita }

final List<Classificacao> listaClassificacao = <Classificacao>[
  Classificacao(idClassificacao: 1, tipo: "Labubus"),
  Classificacao(idClassificacao: 2, tipo: "Transporte"),
  Classificacao(idClassificacao: 3, tipo: "Alimentação"),
  Classificacao(idClassificacao: 4, tipo: "Lazer"),
];
final List<String> listaRecorrencia = <String>[
  "Sem Recorrencia",
  "Diaria",
  "Semanal",
  "Mensal",
  "Anual",
];

void _cancelar(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

class _TelaTransacoesState extends State<TelaTransacoes> {
  OpcoesTransacao? _opcoesTransacao = OpcoesTransacao.despesa;
  final TextEditingController _dateController = TextEditingController();
  final _valorController = CurrencyInputController(initialValue: 0.0);

  String dropdownValue = listaClassificacao.first.tipo;
  String valorDropdownRecorrencia = listaRecorrencia.first;
  int qtsDias = 0;
  int qtsMeses = 0;
  int qtsAnos = 0;
  String _descricaoTransacao = "";
  CatColors cores = CatColors(
    paleta: int.parse(localStorage.getItem('paleta') ?? '1'),
  );

  // Variáveis para carregar meta/cofrinho
  int? idMeta;
  int? idCofrinho;
  OpcoesTransacao tipoMetaCofrinho = OpcoesTransacao.despesa;

  @override
  void dispose() {
    _dateController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _trocar() {
    //Trocar icone e texto
  }

  Future<void> _salvar() async {
    try {
      DateFormat inputFormat = DateFormat('yyyy/MM/dd');
      DateTime parsedDate = DateFormat(
        'dd/MM/yyyy',
      ).parse(_dateController.text);
      int? idRecorrencia = null;
      if (valorDropdownRecorrencia != "Sem Recorrencia") {
        idRecorrencia = await Recorrenciaservices().CriarRecorrencia(
          qtsDias,
          qtsMeses,
          qtsAnos,
        );
      }
      double valorTransacao = _opcoesTransacao == OpcoesTransacao.despesa
          ? -_valorController.doubleValue
          : _valorController.doubleValue;
      String resp = await TransacaoServices().CriarTransacao(
        _descricaoTransacao,
        valorTransacao,
        parsedDate.toIso8601String(),
        idRecorrencia,
        listaClassificacao
            .firstWhere((c) => c.tipo == dropdownValue)
            .idClassificacao,
        idMeta,
        idCofrinho,
      );

      // Mostrar o AlertDialog de sucesso
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sucesso"),
            content: Text("Transação criada com sucesso!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o dialog
                  Navigator.pushReplacementNamed(context, AppRotas.inicial);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Mostrar o AlertDialog de erro
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao criar transação: ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
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

  Future<void> _abrirDialogMetaCofrinho(int idClassificacao) async {
    // Mostrar loading enquanto carrega
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: cores.corSecundaria),
        );
      },
    );

    try {
      // Carregar metas e cofrinhos da API
      final metaService = Metaservices();
      final cofrinhoService = CofrinhoServices();

      final List<Metas> metas = await metaService.listarMetasClassificao(
        idClassificacao,
      );
      final List<Cofrinho> cofrinhos =
          await cofrinhoService.ListarCofrinhosClassificacao(idClassificacao);

      // Fechar o loading
      if (!mounted) return;
      Navigator.of(context).pop();

      // Abrir o dialog com os dados
      _mostrarDialogSelecao(metas, cofrinhos);
    } catch (e) {
      // Fechar o loading
      if (!mounted) return;
      Navigator.of(context).pop();

      // Mostrar erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar dados: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _mostrarDialogSelecao(List<Metas> metas, List<Cofrinho> cofrinhos) {
    // Variáveis locais para o estado do dialog
    int? metaSelecionadaTemp;
    int? cofrinhoSelecionadoTemp;
    OpcoesTransacao tipoSelecionado = OpcoesTransacao.despesa;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                "Vincular Meta/Cofrinho",
                style: TextStyle(
                  color: cores.secundaria,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Checkboxes para selecionar tipo
                    Text(
                      "Selecione o tipo:",
                      style: TextStyle(
                        color: cores.secundaria,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text("Despesa (Meta)"),
                      value: tipoSelecionado == OpcoesTransacao.despesa,
                      onChanged: (bool? value) {
                        if (value == true) {
                          setStateDialog(() {
                            tipoSelecionado = OpcoesTransacao.despesa;
                            cofrinhoSelecionadoTemp = null;
                          });
                        }
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      title: const Text("Receita (Cofrinho)"),
                      value: tipoSelecionado == OpcoesTransacao.receita,
                      onChanged: (bool? value) {
                        if (value == true) {
                          setStateDialog(() {
                            tipoSelecionado = OpcoesTransacao.receita;
                            metaSelecionadaTemp = null;
                          });
                        }
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const Divider(),
                    const SizedBox(height: 8),

                    // Mostrar lista de Metas se despesa estiver selecionada
                    if (tipoSelecionado == OpcoesTransacao.despesa) ...[
                      Text(
                        "Selecione uma Meta:",
                        style: TextStyle(
                          color: cores.secundaria,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (metas.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Nenhuma meta disponível para esta classificação",
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        ...metas.map((meta) {
                          return RadioListTile<int>(
                            title: Text(meta.nome),
                            subtitle: Text(
                              "Limite: R\$ ${meta.gastoLimite.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 12),
                            ),
                            value: meta.idMeta,
                            groupValue: metaSelecionadaTemp,
                            onChanged: (int? value) {
                              setStateDialog(() {
                                metaSelecionadaTemp = value;
                              });
                            },
                          );
                        }).toList(),
                    ],

                    // Mostrar lista de Cofrinhos se receita estiver selecionada
                    if (tipoSelecionado == OpcoesTransacao.receita) ...[
                      Text(
                        "Selecione um Cofrinho:",
                        style: TextStyle(
                          color: cores.secundaria,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (cofrinhos.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Nenhum cofrinho disponível para esta classificação",
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        ...cofrinhos.map((cofrinho) {
                          return RadioListTile<int>(
                            title: Text(cofrinho.nome),
                            subtitle: Text(
                              "Economia: R\$ ${cofrinho.economia.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 12),
                            ),
                            value: cofrinho.idCofrinho,
                            groupValue: cofrinhoSelecionadoTemp,
                            onChanged: (int? value) {
                              setStateDialog(() {
                                cofrinhoSelecionadoTemp = value;
                              });
                            },
                          );
                        }).toList(),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: cores.corTerciaria),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cores.corSecundaria,
                  ),
                  onPressed: () {
                    // Validar se algo foi selecionado
                    if (tipoSelecionado == OpcoesTransacao.despesa &&
                        metaSelecionadaTemp != null) {
                      setState(() {
                        idMeta = metaSelecionadaTemp;
                        idCofrinho = null;
                        _opcoesTransacao = OpcoesTransacao.despesa;
                      });
                      Navigator.of(context).pop();

                      final metaSelecionada = metas.firstWhere(
                        (m) => m.idMeta == metaSelecionadaTemp,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Meta '${metaSelecionada.nome}' vinculada!",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (tipoSelecionado == OpcoesTransacao.receita &&
                        cofrinhoSelecionadoTemp != null) {
                      setState(() {
                        idCofrinho = cofrinhoSelecionadoTemp;
                        idMeta = null;
                        _opcoesTransacao = OpcoesTransacao.receita;
                      });
                      Navigator.of(context).pop();

                      final cofrinhoSelecionado = cofrinhos.firstWhere(
                        (c) => c.idCofrinho == cofrinhoSelecionadoTemp,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Cofrinho '${cofrinhoSelecionado.nome}' vinculado!",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Mostrar mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            tipoSelecionado == OpcoesTransacao.despesa
                                ? "Selecione uma meta!"
                                : "Selecione um cofrinho!",
                          ),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Vincular",
                    style: TextStyle(color: cores.complementar),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                              icon: Icon(
                                Icons.menu,
                                color: cores.complementar,
                                size: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: TitleTelaWidget(
                                titulo: "Planeje Transações",
                                tamanho: 50,
                                qtsBolas: 11,
                                overlapFactor: 0.45,
                                tamanhoFonte: 38.0,
                                cores: CatColors(paleta: 2),
                              ),
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
                            icon: Icon(
                              Icons.visibility_off,
                              color: cores.complementar,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Saldo",
                            style: TextStyle(color: cores.complementar),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Valor da transação",
                        style: TextStyle(color: cores.secundaria, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _valorController,
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
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Verticalselectwidget<OpcoesTransacao>(
                                      label: 'Despesa',
                                      value: OpcoesTransacao.despesa,
                                      groupValue: _opcoesTransacao,
                                      cores: cores,
                                      onChanged: (value) => setState(
                                        () => _opcoesTransacao = value,
                                      ),
                                    ),
                                    Verticalselectwidget<OpcoesTransacao>(
                                      label: 'Receita',
                                      value: OpcoesTransacao.receita,
                                      groupValue: _opcoesTransacao,
                                      cores: cores,
                                      onChanged: (value) => setState(
                                        () => _opcoesTransacao = value,
                                      ),
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
                                Text(
                                  "Data de início",
                                  style: TextStyle(
                                    color: cores.corSecundaria,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
                                  style: TextStyle(color: cores.complementar),
                                  decoration: InputDecoration(
                                    labelText: 'Data da transação',
                                    labelStyle: TextStyle(
                                      color: cores.complementar,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: cores.complementar,
                                    ),
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
                        onChanged: (value) {
                          _descricaoTransacao = value;
                        },
                        maxLength: 150,
                        decoration: InputDecoration(
                          hintText: "Descrição da transação",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 4,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Classificação",
                        style: TextStyle(color: cores.secundaria, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              alignment: AlignmentDirectional.center,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: cores.corTerciaria,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: cores.corTerciaria,
                                    width: 2,
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              value:
                                  listaClassificacao.any(
                                    (c) => c.tipo == dropdownValue,
                                  )
                                  ? dropdownValue
                                  : null,
                              icon: const Icon(Icons.arrow_drop_down),
                              onChanged: (String? value) =>
                                  setState(() => dropdownValue = value!),
                              items: listaClassificacao
                                  .map<DropdownMenuItem<String>>((
                                    Classificacao value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value.tipo,
                                      child: Center(
                                        child: Text(
                                          value.tipo,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cores.corSecundaria,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () async {
                              // Obter o ID da classificação selecionada
                              final classificacaoSelecionada =
                                  listaClassificacao.firstWhere(
                                    (c) => c.tipo == dropdownValue,
                                    orElse: () => listaClassificacao.first,
                                  );
                              await _abrirDialogMetaCofrinho(
                                classificacaoSelecionada.idClassificacao,
                              );
                            },
                            icon: Icon(
                              Icons.money_rounded,
                              color: cores.complementar,
                              size: 20,
                            ),
                            label: Text(
                              "Selecionar Meta/Cofrinho",
                              style: TextStyle(
                                color: cores.complementar,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Recorrência",
                        style: TextStyle(color: cores.secundaria, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        alignment: AlignmentDirectional.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: cores.corTerciaria,
                              width: 2,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        value: valorDropdownRecorrencia,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) =>
                            setState(() => valorDropdownRecorrencia = value!),
                        items: listaRecorrencia.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      if (valorDropdownRecorrencia != "Sem Recorrencia")
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            setState(() {
                              int intValue = int.tryParse(value) ?? 0;
                              switch (valorDropdownRecorrencia) {
                                case "Diaria":
                                  qtsDias = intValue;
                                  qtsMeses = 0;
                                  qtsAnos = 0;
                                  break;
                                case "Semanal":
                                  qtsDias = intValue * 7;
                                  qtsMeses = 0;
                                  qtsAnos = 0;
                                  break;
                                case "Mensal":
                                  qtsDias = 0;
                                  qtsMeses = intValue;
                                  qtsAnos = 0;
                                  break;
                                case "Anual":
                                  qtsDias = 0;
                                  qtsMeses = 0;
                                  qtsAnos = intValue;
                                  break;
                                default:
                                  qtsDias = 0;
                                  qtsMeses = 0;
                                  qtsAnos = 0;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText:
                                "Quantos ${valorDropdownRecorrencia.toLowerCase()}?",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: cores.corTerciaria,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          maxLines: 1,
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
                      onPressed: () => _salvar(),
                      child: Text(
                        "Efetuar",
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
