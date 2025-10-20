import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/BolasLogin.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';

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

  Future<void> _showEmailDialog() async {
    final emailController = TextEditingController(text: txtEmail.text);
    final formKey = GlobalKey<FormState>();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informe seu e-mail'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                hintText: 'catlover@meow.com',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'Digite um e-mail';
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
                if (!ok) return 'E-mail inválido';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  setState(() {
                    txtEmail.text = emailController.text.trim();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    txtUsuario.dispose();
    txtEmail.dispose();
    txtSenha.dispose();
    txtConfirmaSenha.dispose();
    super.dispose();
  }

  Future<void> _CodigoExistente() async {
    await _showEmailDialog();
    final email = txtEmail.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um email válido para ir para a confirmação.'),
        ),
      );
      return;
    }
    Navigator.pushReplacementNamed(
      context,
      AppRotas.confirmacao,
      arguments: {'email': email, 'isCreateCount': true},
    );
  }

  Future<void> _fazerCadastro() async {
    try {
      if (txtSenha.text == txtConfirmaSenha.text) {
        var httpUsuarios = UsuarioServices();
        var okCad = await httpUsuarios.CadastrarUsuario(
          txtUsuario.text,
          txtEmail.text,
          txtSenha.text,
        );
        if (okCad) {
          Navigator.pushReplacementNamed(
            context,
            AppRotas.confirmacao,
            arguments: {'email': txtEmail.text, 'isCreateCount': true},
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao cadastrar. Tente novamente.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar.${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CatColors cores = CatColors(paleta: 2);
    return Scaffold(
      backgroundColor: cores.corPrimaria,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: BolasLogin(),
              child: Container(
                height: 175,
                color: cores.corSecundaria.withOpacity(0.9),
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
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
                      const SizedBox(height: 8),
                      
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
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRotas.login,
                                  );
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
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () => _CodigoExistente(),
                          child: Text("Já tenho código"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
