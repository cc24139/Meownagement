import 'package:front_meow/models/Meta.dart';
import 'package:front_meow/models/transacao.dart';

class MetasPorcentagemViewModel {
  Metas meta;
  List<Transacao> transacoes;
  double totalGasto;

  MetasPorcentagemViewModel({
    required this.meta,
    required this.transacoes,
    required this.totalGasto
  });

  factory MetasPorcentagemViewModel.fromJson(Map<String, dynamic> json) {
    MetasPorcentagemViewModel result = MetasPorcentagemViewModel(
      meta: Metas.fromJson(json['metas']),
      transacoes: List<Transacao>.from(
        (json['transacoes'] as List).map((e) => Transacao.fromJson(e)),
      ),
      totalGasto: json['totalGasto']?.toDouble() ?? 0.0,
    );

    if (result.totalGasto > 100.0) {
      result.totalGasto = 100.0;
    }

    return result;
  }
}
