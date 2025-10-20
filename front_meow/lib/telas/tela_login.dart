import 'package:flutter/material.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioLoginViewModel.dart';
import 'package:localstorage/localstorage.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  void dispose() {
    txtEmail.dispose();
    txtSenha.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _fazerLogin() async {
    if (txtEmail.text.isNotEmpty && txtSenha.text.isNotEmpty) {
      var httpUsuarios = UsuarioServices();
      print("Chamando LoginUsuario...");
      var sucesso = await httpUsuarios.LoginUsuario(
        UsuarioLoginViewModel(email: txtEmail.text, senha: txtSenha.text),
        localStorage,
      );
      print("Resposta de LoginUsuario: $sucesso");

      if (sucesso!) {
        Navigator.pushReplacementNamed(context, AppRotas.inicial);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email ou senha inválidos")));
        txtSenha.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Lohit-Tamil",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: txtEmail,
                    decoration: const InputDecoration(
                      labelText: "Digite seu Email",
                      hintText: "catlover@meow.com",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: txtSenha,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Digite sua Senha",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Esqueceu sua senha? "),
                      SizedBox(
                        width: 250,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRotas.alterarSenha,
                            );
                          },
                          child: const Text("Recuperar senha"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não possui uma conta? "),
                      SizedBox(
                        width: 250,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRotas.cadastro,
                            );
                          },
                          child: const Text("Cadastre-se"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _fazerLogin();
                    },
                    child: Text("Entrar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
