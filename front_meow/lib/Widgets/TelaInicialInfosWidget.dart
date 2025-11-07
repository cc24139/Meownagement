import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/GavetaPageView.dart';
import 'package:front_meow/Widgets/HistoricoTransferencias.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/Widgets/TransacoesRecorrentes.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Cofrinho.dart';
import 'package:front_meow/models/transacao.dart';
import 'package:front_meow/services/ViewModel/View/MetaPorcentagemVIewModel.dart';
import 'MetasPageView.dart';
import 'package:front_meow/services/metaServices.dart';
import 'SemMetasEncontradas.dart';
import '../services/cofrinhoServices.dart';
import 'SemGavetasEncontradas.dart';
import '../services/transacaoServices.dart';
import '../locator.dart';

class Telainicialinfoswidget extends StatelessWidget {
  final QualInfo qualInfo; // Transações, Metas etc
  final CatColors cor;

  final dynamic metaServices = locator<Metaservices>();
  final dynamic cofrinhoServices = locator<CofrinhoServices>();
  final dynamic transacaoServices = locator<TransacaoServices>();

  Telainicialinfoswidget({
    super.key,
    required this.qualInfo,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    print(qualInfo);
    switch (qualInfo) {
      case QualInfo.transacoes:
        return Column(children: [_transacoes()]);
      case QualInfo.metas:
        return Column(children: [_metas()]);
      case QualInfo.gaveta:
        return Column(children: [_gaveta()]);
      case QualInfo.transacoesRecorrentes:
        return Column(children: [_transacoesRecorrentes()]);
    }
  }

   Widget _metas() {
    return FutureBuilder<List<MetasPorcentagemViewModel>>(
    future: metaServices.listarMetasComPorcentagem(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar metas'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return SemMetasEncontradas(cor: cor);
      } else {
        return MetasPageView(metas: snapshot.data!, cor: cor);
      }
    },
  );
  }

  Widget _transacoes() {
    return FutureBuilder<List<Transacao>>(
    future: transacaoServices.ListarTransacoes(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar metas'));
      } else {
        return HistoricoTransferencias(transacoes: snapshot.data!, cor: cor);
      }
    },
  );
  }

  Widget _gaveta() {
    return FutureBuilder<List<Cofrinho>>(
    future: cofrinhoServices.ListarCofrinhos(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar metas'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return SemGavetasEncontradas(cor: cor);
      } else {
        return GavetaPageView(gaveta: snapshot.data!, cor: cor);
      }
    },
  );
  }

  Widget _transacoesRecorrentes() {
    return FutureBuilder<List<Transacao>>(
    future: transacaoServices.ListarTransacoesRecorrentes(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar metas'));
      } else {
        return TransacoesRecorrentes(transacoes: snapshot.data!, cor: cor);
      }
    },
  );
  }
}

