import 'package:flutter/material.dart';
import 'package:front_meow/rotas.dart';

class TelaAlterarSenha extends StatefulWidget {
  const TelaAlterarSenha({super.key});

  @override
  State<TelaAlterarSenha> createState() => _TelaAlterarSenhaState();
}

class _TelaAlterarSenhaState extends State<TelaAlterarSenha> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNovaSenha = TextEditingController();
  TextEditingController txtConfirmarSenha = TextEditingController();

  @override
  void dispose() {
    txtEmail.dispose();
    txtNovaSenha.dispose();
    txtConfirmarSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alterar Senha",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
          ),
        ),
        backgroundColor: Colors.transparent,
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
                    hintText: "email@exemplo.com",
                  ),
                ),
              ),

              SizedBox(
                width: 250,
                child: TextField(
                  controller: txtNovaSenha,
                  decoration: const InputDecoration(
                    labelText: "Digite sua Nova Senha",
                    hintText: "Nova Senha",
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: txtConfirmarSenha,
                  decoration: const InputDecoration(
                    labelText: "Confirme sua Nova Senha",
                    hintText: "Confirmação da Nova Senha",
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para alterar a senha
                  Navigator.pushReplacementNamed(context, AppRotas.confirmacao);
                },
                child: const Text("Alterar Senha"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
