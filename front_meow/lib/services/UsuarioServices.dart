import 'package:front_meow/services/ViewModel/View/UsuarioLoginViewModel.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:front_meow/model/usuario.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class UsuarioServices extends Http {
  static String urlUsuario = "${Http.url}/usuarios";
  // Token agora é gerenciado pela classe Http

  // Posts

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
      Http.token = data['token'];
      // tem que testar o localsStorage
      storage.setItem('token', Http.token!);
      return ("Login realizado com sucesso");
    } else {
      throw Exception('Failed to login usuario');
    }
  }

  Future<List<UsuarioViewModel>> ListarUsuarios() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      // tem que redirecionar para a tela de login
    }
    final response = await http.get(
      Uri.parse("${urlUsuario}/listar"),
      headers: Http.headers,
    );
    print(response.request);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<UsuarioViewModel>.from(
        data.map((usuario) => UsuarioViewModel.fromJson(usuario)),
      );
    } else {
      throw Exception(
        'Failed to load usuario :' + response.statusCode.toString(),
      );
    }
  }

  Future<List<Usuario>> PesquisarUsuario(String Nome) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      // tem que redirecionar para a tela de login
    }

    final response = await http.get(
      Uri.parse("${urlUsuario}/pesquisar?Nome=$Nome"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Usuario>.from(
        data.map((usuario) => Usuario.fromJson(usuario)),
      );
    } else {
      throw Exception('Failed to load usuario');
    }
  }

  Future<String> CadastrarUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse("${urlUsuario}/cadastrar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 201) {
      return ("Usuário cadastrado com sucesso");
    } else {
      throw Exception('Failed to create usuario');
    }
  }

  Future<String> ConfirmarEmailUsuario(String Email, String Code) async {
    final response = await http.post(
      Uri.parse("${urlUsuario}/confirmarEmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Email': Email, 'Code': Code}),
    );

    if (response.statusCode == 200) {
      return ("Email confirmado com sucesso");
    } else {
      throw Exception('Código ou Email inválido');
    }
  }

  //Patch

  Future<String> EditarUsuario(String Nome, String Biografia) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      //tem que redirecionar para a tela de login
    }
    final response = await http.patch(
      Uri.parse("${urlUsuario}/editar"),
      headers: Http.headers,
      body: jsonEncode(<String, String>{'Nome': Nome, 'Biografia': Biografia}),
    );

    if (response.statusCode == 200) {
      return ("Usuário editado com sucesso");
    } else {
      throw Exception('Failed to edit usuario');
    }
  }

  Future<String> EsqueceuSenhaUsuario(String Nome, String Senha) async {
    final response = await http.patch(
      Uri.parse("${urlUsuario}/esqueceuSenha"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Nome': Nome, 'Senha': Senha}),
    );

    if (response.statusCode == 200) {
      return ("Codigo enviado para o email cadastrado");
    } else {
      throw Exception('Failed to change password usuario');
    }
  }

  Future<String> ConfirmarEsquecerSenhaUsuario(
    String Email,
    String Code,
  ) async {
    final response = await http.patch(
      Uri.parse("${urlUsuario}/confirmarEsqueceuSenha"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Email': Email, 'Code': Code}),
    );

    if (response.statusCode == 200) {
      return ("Código confirmado com sucesso");
    } else {
      throw Exception('Código ou Nome inválido');
    }
  }

  Future<String> PerfilUsuario() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
      //tem que redirecionar para a tela de login
    }
    final response = await http.get(
      Uri.parse("${urlUsuario}/perfil"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load perfil usuario');
    }
  }
}
