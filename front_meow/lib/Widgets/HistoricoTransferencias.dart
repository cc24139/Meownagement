import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/transacao.dart';

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
    quantiaDinheiro: 200.00,
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
          child: HistoricoTransferencias(transacoes: transacoesExemplo, cor: CatColors(paleta: 2)),
        ),
      ),
    ),
  );
}

class HistoricoTransferencias extends StatelessWidget {
  final List<Transacao> transacoes;
  final CatColors cor;

  const HistoricoTransferencias({super.key, required this.transacoes, required this.cor});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 425,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cor.tercearia, width: 2),
        boxShadow: [
          BoxShadow(
            color: cor.tercearia.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Histórico",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (context, index) {
                final transacao = transacoes[index];
                final ganhou = transacao.quantiaDinheiro > 0;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            ganhou ? Icons.arrow_upward : Icons.arrow_downward,
                            color: ganhou ? Colors.green : Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd/MM/yy').format(transacao.dataCriacao),
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                              Text(
                                "Lazer: ${transacao.idClassificacao}",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "${ganhou ? "R\$ " : "-R\$ "}${transacao.quantiaDinheiro.abs().toStringAsFixed(2)}",
                            style: TextStyle(
                              color: ganhou ? Color(0xFF02B74D) : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Londrina",
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Adiciona a linha de separação, exceto no último item
                    if (index != transacoes.length - 1)
                      Center( 
                        child: Container(
                          width: 225, 
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
