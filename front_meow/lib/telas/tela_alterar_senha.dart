import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/BolasLogin.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';

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
                            "Alterar Senha",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 45,
                              fontFamily: "Londrina",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
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
                        controller: txtNovaSenha,
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Confirmar senha",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: txtConfirmarSenha,
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
                      SizedBox(
                        height: 70,
                      ),
                      ElevatedButtonWidget(
                        text: "Cadastrar",
                        onPressed: () {
                          UsuarioServices().EsqueceuSenhaUsuario(txtEmail.text, txtNovaSenha.text);
                          Navigator.pushReplacementNamed(context, AppRotas.confirmacao, arguments: {'email': txtEmail.text, 'isCreateCount': false});
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
