import 'package:flutter/material.dart';
import 'package:front_meow/rotas.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtConfirmaSenha = TextEditingController();

  @override
  void dispose() {
    txtUsuario.dispose();
    txtEmail.dispose();
    txtSenha.dispose();
    txtConfirmaSenha.dispose();
    super.dispose();
  }

  void _fazerCadastro() {
    if (txtSenha.text == txtConfirmaSenha.text) {
      Navigator.pushReplacementNamed(context, AppRotas.confirmacao);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro",
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
                  controller: txtUsuario,
                  decoration: const InputDecoration(
                    labelText: "Digite seu nome de usuario",
                    hintText: "Ronaldo123",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
                    labelText: "Digite sua senha",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: txtConfirmaSenha,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirme sua senha",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Já possui uma conta? "),
                    SizedBox(
                      width: 250,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRotas.login);
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: _fazerCadastro,
                  child: Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
