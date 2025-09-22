import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioLoginViewModel.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:front_meow/model/usuario.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class UsuarioServices extends Http {
  static String urlUsuario = "${Http.url}/usuarios";
  static String? token =
      ""; //Nas outras rotas vai ter que pegar do localStorage

  //Posts

  Future<String> LoginUsuario(
    UsuarioLoginViewModel usuario,
    LocalStorage storage,
  ) async {
    final response = await http.post(
      Uri.parse("${urlUsuario}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      token = data['token'];
      //tem que testar o localsStorage
      storage.setItem('token', token!);
      return ("Login realizado com sucesso");
    } else {
      throw Exception('Failed to login usuario');
    }
  }

  //Gets
  Future<UsuarioViewModel> GetUsuarios() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      //tem que redirecionar para a tela de login
    }
    final response = await http.get(
      Uri.parse("${urlUsuario}/listar"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UsuarioViewModel.fromJson(data);
    } else {
      throw Exception('Failed to load usuario');
    }
  }

  //Patch

  Future<String> EditarUsuario(String Nome, String Biografia) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      //tem que redirecionar para a tela de login
    }
    final response = await http.patch(
      Uri.parse("${urlUsuario}/editar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token!,
      },
      body: jsonEncode(<String, String>{
        'Nome': Nome,
        'Biografia': Biografia,
      }),
    );

    if (response.statusCode == 200) {
      return ("Usuário editado com sucesso");
    } else {
      throw Exception('Failed to edit usuario');
    }
  }
}
