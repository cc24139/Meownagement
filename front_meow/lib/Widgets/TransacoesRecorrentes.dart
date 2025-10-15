import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/transacao.dart';
import 'package:intl/intl.dart';

List<Transacao> transacoesExemplo = [
  Transacao(
    idTransacao: 1,
    idUsuario: 1,
    idClassificacao: 1,
    quantiaDinheiro: -50.00,
    dataCriacao: DateTime.now().subtract(Duration(days: 1)),
    saldoAtual: 0,
    dataFinalizacao: DateTime.now().subtract(Duration(days: 1)),
    nome: "Compra no mercado",    feita: "Sim",
    idRecorrencia: null,
  ),
  Transacao(
    idTransacao: 2,
    idUsuario: 1,
    idClassificacao: 2,
    quantiaDinheiro: 2000.00,
    dataCriacao: DateTime.now().subtract(Duration(days: 2)),
    saldoAtual: 0,
    dataFinalizacao: DateTime.now().subtract(Duration(days: 2)),
    nome: "Venda de produto",
    feita: "Sim",
    idRecorrencia: null,
  ),
  Transacao(
    idTransacao: 3,
    idUsuario: 1,
    idClassificacao: 3,
    quantiaDinheiro: -30.00,
    dataCriacao: DateTime.now().subtract(Duration(days: 3)),
    saldoAtual: 0,
    dataFinalizacao: DateTime.now().subtract(Duration(days: 3)),
    nome: "Lanche com amigos",
    feita: "Sim",
    idRecorrencia: null,
  ),
  Transacao(
    idTransacao: 4,
    idUsuario: 1,
    idClassificacao: 4,
    quantiaDinheiro: 150.00,
    dataCriacao: DateTime.now().subtract(Duration(days: 4)),
    saldoAtual: 0,
    dataFinalizacao: DateTime.now().subtract(Duration(days: 4)),
    nome: "Freelance",
    feita: "Sim",
    idRecorrencia: null,
  ),
];

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TransacoesRecorrentes(transacoes: transacoesExemplo, cor: CatColors(paleta: 2)),
        ),
      ),
    ),
  );
}

class TransacoesRecorrentes extends StatelessWidget {
  final List<Transacao> transacoes;
  final CatColors cor;

  const TransacoesRecorrentes({super.key, required this.transacoes, required this.cor});

  void _mostrarDialogoDeExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
            side: BorderSide(color: cor.corTerciaria, width: 2), // Borda vermelha
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            height: 200,
            width: 275, // Altura do conteúdo do diálogo
            child: Stack(
              children: <Widget>[
                // Conteúdo principal do diálogo
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Deseja mesmo excluir\na recorrência",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButtonWidget(text: "Excluir", onPressed: () {}, highSize: ButtonSize.pequeno, widthSize: ButtonSize.medio, catColors: cor),
                    ],
                  ),
                ),
                // Botão 'X' para fechar
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.of(context).pop(); // Apenas fecha o diálogo
                    },
                  ),
                ),
                // Botão 'X' para fechar
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.of(context).pop(); // Apenas fecha o diálogo
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definindo as proporções do layout para reutilizar nos títulos e nos itens
    const int flexData = 3;
    const int flexClassificacao = 4;
    const int flexValor = 3;

    return Container(
      width: 300,
      height: 425,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cor.tercearia, width: 2),
        boxShadow: [
          BoxShadow(
            color: cor.tercearia.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Transações Recorrentes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adiciona um padding para alinhar
            child: Row(
              children: [
                const Expanded(
                  flex: flexData,
                  child: Text("Próxima Recorrência:", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
                SizedBox(width: 18), // Espaço para o divisor
                const Expanded(
                  flex: flexClassificacao,
                  child: Text("Classificação:", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
                SizedBox(width: 18), // Espaço para o divisor
                const Expanded(
                  flex: flexValor,
                  child: Text("Valor:", textAlign: TextAlign.start, style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
                // AQUI: Um espaço reservado para alinhar com o ícone de remover
                const SizedBox(width: 24),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (context, index) {
                final transacao = transacoes[index];
                final ganhou = transacao.quantiaDinheiro > 0;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          // AQUI: Substituímos SizedBox por Expanded para garantir o alinhamento
                          Expanded(
                            flex: flexData,
                            child: Text(
                              DateFormat('dd/MM/yy').format(transacao.dataFinalizacao),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 20,
                            color: cor.tercearia,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Expanded(
                            flex: flexClassificacao,
                            child: Text(
                              transacao.nome,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis, // Evita que o texto quebre a linha
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 20,
                            color: cor.tercearia,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Expanded(
                            flex: flexValor,
                            child: Text(
                              "${ganhou ? "R\$ " : "-R\$ "}${transacao.quantiaDinheiro.abs().toStringAsFixed(2)}",
                              style: TextStyle(
                                color: ganhou ? const Color(0xFF02B74D) : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Londrina",
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _mostrarDialogoDeExclusao(context);
                            },
                            borderRadius: BorderRadius.circular(30), // Efeito de clique circular
                            child: const Icon(Icons.remove_circle_outline, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    if (index != transacoes.length - 1)
                      Center(
                        child: Container(
                          width: 275,
                          height: 2,
                          color: cor.tercearia,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
