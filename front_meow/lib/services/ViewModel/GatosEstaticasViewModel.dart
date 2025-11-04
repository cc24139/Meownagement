import 'package:front_meow/models/gato.dart';

class GatosEstaticasViewModel {
  final Gato gato;
  final double qtsPossuem;
  final int qtsCopias;

  GatosEstaticasViewModel({
    required this.gato,
    required this.qtsPossuem,
    required this.qtsCopias,
  });

  factory GatosEstaticasViewModel.fromJson(Map<String, dynamic> json) {
    return GatosEstaticasViewModel(
      gato: Gato.fromJson(json['gato']),
      qtsPossuem: double.parse(json['qtsPossuem'].toStringAsFixed(2)),
      qtsCopias: json['qtsCopias'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'gato': gato,
      'qtsPossuem': qtsPossuem,
      'qtsCopias': qtsCopias,
    };
  }
}