import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/GavetaPageView.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Meta.dart';
import 'package:front_meow/models/Cofrinho.dart';
import 'MetasPageView.dart';
import 'package:front_meow/services/metaServices.dart';
import 'SemMetasEncontradas.dart';
import '../services/cofrinhoServices.dart';
import 'SemGavetasEncontradas.dart';

class Telainicialinfoswidget extends StatelessWidget {
  final QualInfo qualInfo; // Transações, Metas etc
  final CatColors cor;
  final Metaservices metaServices;
  final CofrinhoServices cofrinhoServices;

  const Telainicialinfoswidget({
    super.key,
    required this.qualInfo,
    required this.cor,
    required this.metaServices,
    required this.cofrinhoServices,
  });

  @override
  Widget build(BuildContext context) {
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
    return FutureBuilder<List<Metas>>(
    future: metaServices.listarMetas(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar metas'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return SemMetasEncontradas(cor: cor);
      } else {
        return MetasPageView(metas: snapshot.data!, cor: cor,);
      }
    },
  );
  }

  Widget _transacoes() {
    return Text("Transações");
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
    return Text("Transações Recorrentes");
  }

}

