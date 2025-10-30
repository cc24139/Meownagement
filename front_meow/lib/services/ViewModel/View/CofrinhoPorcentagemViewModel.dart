import 'package:front_meow/models/cofrinho.dart';

class CofrinhoPorcentagemViewModel {
  final Cofrinho cofrinho;
  final double totalGanho;

  CofrinhoPorcentagemViewModel({
    required this.cofrinho,
    required this.totalGanho,
  });

  factory CofrinhoPorcentagemViewModel.fromJson(Map<String, dynamic> json) {
    return CofrinhoPorcentagemViewModel(
      cofrinho: Cofrinho.fromJson(json['cofrinho']),
      totalGanho: json['totalGanho'].toDouble(),
    );
  }


}