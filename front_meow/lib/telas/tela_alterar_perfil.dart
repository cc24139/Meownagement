import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:localstorage/localstorage.dart';

class TelaAlterarPerfil extends StatefulWidget {
  const TelaAlterarPerfil({super.key});

  @override
  State<TelaAlterarPerfil> createState() => _TelaAlterarPerfilState();
}

class _TelaAlterarPerfilState extends State<TelaAlterarPerfil> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  CatColors cores = CatColors(
    paleta: int.parse(localStorage.getItem('paleta') ?? '1'),
  );

  int meowCoins = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    UsuarioServices().PerfilUsuario().then((usuario) {
      setState(() {
        meowCoins = usuario!.pontos!;
        txtNome.text = usuario!.nome!;
        txtBio.text = usuario.biografia ?? "Sem biografia.";
      });
    }).catchError((error) {
      // nao esta logado -> manda de volta pro login
      // pop-up avisando que precisa logar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: cores.corPrimaria,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.redAccent),
                SizedBox(width: 8),
                const Text(
                  "Erro",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Text(
              "Você precisa estar logado para acessar essa tela.",
              style: TextStyle(color: Colors.redAccent),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text("Ir ao Login"),
              ),
            ],
          );
        },
      );
    });
  }

  void _salvar() async {
    await UsuarioServices().EditarUsuario(
      txtNome.text,
      txtBio.text,
    );
    Navigator.pushReplacementNamed(context, AppRotas.inicial);
  }

  void _cancelar() {
    Navigator.pushReplacementNamed(context, AppRotas.inicial);
  }

  @override
  void dispose() {
    txtNome.dispose();
    txtBio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  Text(
                    "Perfil",
                    style: TextStyle(
                      color: cores.complementar,
                      fontSize: 38,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nome do perfil", 
                    style: TextStyle(
                      color: cores.corSecundaria,
                       fontSize: 16
                    )
                  ),
                ],
              ),
              TextField(
                controller: txtNome,
                style: TextStyle(color: cores.secundaria, fontSize: 20),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: cores.corTerciaria,
                      width: 2
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: cores.corTerciaria,
                      width: 2
                    )
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bio", 
                    style: TextStyle(
                      color: cores.corSecundaria,
                       fontSize: 16
                    )
                  ),
                ],
              ),
              TextField(
                controller: txtBio,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 6,
                maxLength: 250,
                style: TextStyle(color: cores.secundaria, fontSize: 20),
                decoration: InputDecoration(
                  counterStyle: TextStyle(color: cores.secundaria),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: cores.corTerciaria,
                      width: 2
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: cores.corTerciaria,
                      width: 2
                    )
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        backgroundColor: cores.corTerciaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _cancelar();
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        backgroundColor: cores.corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _salvar(
                      ),
                      child: Text(
                        "Salvar perfil",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: cores.corPrimaria,
    );
  }
}
