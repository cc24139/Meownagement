import 'package:flutter/widgets.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/meta.dart';
import 'MetasPageView.dart';
import 'package:front_meow/services/metaServices.dart';

class Telainicialinfoswidget extends StatelessWidget {
  final QualInfo qualInfo; // Transações, Metas etc
  final CatColors cor;
  final Metaservices metaServices = Metaservices();

  const Telainicialinfoswidget({
    super.key,
    required this.qualInfo,
    required this.cor,
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
    var meta = metaServices.listarMetas();
    return MetasPageView(meta); // Passa as metas para o widget
  }

  Widget _transacoes() {
    return Text("Transações");
  }

  Widget _gaveta() {
    return Text("Gaveta");
  }

  Widget _transacoesRecorrentes() {
    return Text("Transações Recorrentes");
  }

}

