import 'package:flutter/material.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/telas/telaAlterarSenha.dart';
import 'package:front_meow/telas/telaCadastro.dart';

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

  void _fazerLogin() {
    if (txtEmail.text == "meow.gmail.com" && txtSenha.text == "meow") {
      Text("ciacnia");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TelaLogin()),
      );
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
            fontFamily: "Arial",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
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
              SizedBox(
                width: 250,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, appRotas.alterarSenha);
                  },
                  child: const Text("Esqueci minha senha"),
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
                          Navigator.pushNamed(context, appRotas.cadastro);
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
                  onPressed: _fazerLogin,
                  child: Text("Entrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
