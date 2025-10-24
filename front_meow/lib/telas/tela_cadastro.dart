import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/BolasLogin.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
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
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cadastro",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 45,
                              fontFamily: "Londrina",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: txtUsuario,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: txtEmail,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Senha",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: txtSenha,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Confirmar Senha",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      
                      TextField(
                        controller: txtConfirmaSenha,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: cores.tercearia,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Já possui uma conta? "),
                            SizedBox(
                              width: 60,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRotas.login,
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),
                      ElevatedButtonWidget(
                        text: "Cadastrar",
                        onPressed: () {
                          _fazerCadastro();
                        },
                        highSize: ButtonSize.grande,
                        widthSize: ButtonSize.grande,
                        catColors: cores,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButtonWidget(
                        text: "Já tenho código",
                        onPressed: () {
                          _CodigoExistente();
                        },
                        highSize: ButtonSize.grande,
                        widthSize: ButtonSize.grande,
                        catColors: cores,
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
