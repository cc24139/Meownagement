import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/BolasLogin.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
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
  CatColors cores = CatColors(paleta: 2);

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: cores.primaria,
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 20),
  //         child: Center(
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 width: 250,
  //                 child: TextField(
  //                   controller: txtEmail,
  //                   decoration: const InputDecoration(
  //                     labelText: "Digite seu Email",
  //                     hintText: "catlover@meow.com",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 30),
  //               SizedBox(
  //                 width: 250,
  //                 child: TextField(
  //                   controller: txtSenha,
  //                   obscureText: true,
  //                   decoration: const InputDecoration(
  //                     labelText: "Digite sua Senha",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 30),
  //               Center(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text("Esqueceu sua senha? "),
  //                     SizedBox(
  //                       width: 250,
  //                       child: TextButton(
  //                         onPressed: () {
  //                           Navigator.pushReplacementNamed(
  //                             context,
  //                             AppRotas.alterarSenha,
  //                           );
  //                         },
  //                         child: const Text("Recuperar senha"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 30),
  //               Center(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text("Não possui uma conta? "),
  //                     SizedBox(
  //                       width: 250,
  //                       child: TextButton(
  //                         onPressed: () {
  //                           Navigator.pushReplacementNamed(
  //                             context,
  //                             AppRotas.cadastro,
  //                           );
  //                         },
  //                         child: const Text("Cadastre-se"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 30),
  //               SizedBox(
  //                 width: 250,
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     _fazerLogin();
  //                   },
  //                   child: Text("Entrar"),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
                            "Login",
                            style: TextStyle(
                              color: cores.secundaria,
                              fontSize: 45,
                              fontFamily: "Londrina",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
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
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Esqueceu sua senha?"),
                            SizedBox(
                              width: 135,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRotas.alterarSenha,
                                  );
                                },
                                child: const Text(
                                  "Recuperar Senha",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Não possui uma conta?"),
                            SizedBox(
                              width: 110,
                              
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRotas.cadastro,
                                  );
                                },
                                child: const Text(
                                  "Cadastre-se",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),
                      ElevatedButtonWidget(
                        text: "Cadastrar",
                        onPressed: () {
                          _fazerLogin();
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
