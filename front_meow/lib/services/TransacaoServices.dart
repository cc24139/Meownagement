import 'dart:io';


import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front_meow/model/transacao.dart';

import 'package:localstorage/localstorage.dart';

class TransacaoServices extends Http {
  static String urlTransacao = "${Http.url}/transacoes";
  static String? token = localStorage.getItem('token');
  
  // Posts
  Future<String> CriarTransacao(String Nome, double QuantiaDinheiro, String DataCriacao, 
                                String DataFinalizacao, int IdOcorrencia, int IdClassificacao) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    
    final response = await http.post(
      Uri.parse("${urlTransacao}/criar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token!,
      },
      body: jsonEncode(
        {
          'nome': Nome,
          'quantiaDinheiro': QuantiaDinheiro,
          'dataCriacao': DataCriacao,
          'dataFinalizacao': DataFinalizacao,
          'idOcorrencia': IdOcorrencia,
          'idClassificacao': IdClassificacao
        },
      ),
    );

    if (response.statusCode == 201) {
      return ("Transação criada com sucesso");
    } else {
      throw Exception('Failed to create transacao');
    }
  }

  // Gets

  
}
