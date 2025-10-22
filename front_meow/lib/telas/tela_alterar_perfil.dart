import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';

class TelaAlterarPerfil extends StatefulWidget {
  const TelaAlterarPerfil({super.key});

  @override
  State<TelaAlterarPerfil> createState() => _TelaAlterarPerfilState();
}

class _TelaAlterarPerfilState extends State<TelaAlterarPerfil> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  CatColors cores = CatColors(paleta: 4);

  void _salvar() {
    //TODO Salvar os dados
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
                        "Criar",
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
