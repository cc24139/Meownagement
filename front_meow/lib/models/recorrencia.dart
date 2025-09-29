class Recorrencia {
  final int idRecorrencia;
  final int qtosDias;
  final int qtosMeses;
  final int qtosAnos;

  Recorrencia({
    required this.idRecorrencia,
    required this.qtosDias,
    required this.qtosMeses,
    required this.qtosAnos,
  });

  factory Recorrencia.fromJson(Map<String, dynamic> json) {
    return Recorrencia(
      idRecorrencia: json['idRecorrencia'],
      qtosDias: json['qtosDias'],
      qtosMeses: json['qtosMeses'],
      qtosAnos: json['qtosAnos'],
    );
  }
}