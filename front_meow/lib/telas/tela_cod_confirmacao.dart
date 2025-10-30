import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/services/UsuarioServices.dart';

class TelaCodConfirmacao extends StatefulWidget {
  final String email;
  final bool isCreateCount;

  const TelaCodConfirmacao({
    super.key,
    required this.email,
    required this.isCreateCount,
  });

  @override
  State<TelaCodConfirmacao> createState() => _TelaCodConfirmacaoState();
}

class _TelaCodConfirmacaoState extends State<TelaCodConfirmacao> {
  Future<bool> _verificarCodigo(
    String codigo,
    bool isCreateCount,
    String email,
  ) async {
    try {
      var httpUsuarios = UsuarioServices();
      if (isCreateCount) {
        var criou = await httpUsuarios.ConfirmarEmailUsuario(email, codigo);
        return criou;
      } else {
        var resetou = await httpUsuarios.ConfirmarEsquecerSenhaUsuario(
          email,
          codigo,
        );
        return resetou;
      }
    } catch (e) {
      return false;
    }
  }

  CatColors cores = CatColors(paleta: 2);
  
  @override
  Widget build(BuildContext context) {
    CatColors cores = CatColors(paleta: 2);
    return Scaffold(     
      backgroundColor: cores.corPrimaria,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirmação por Email",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Londrina",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              Text(
                "Digite o código de 6 dígitos enviado para:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cores.secundaria),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cores.tercearia,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              OtpTextField(
                numberOfFields: 6,
                disabledBorderColor: cores.tercearia,
                focusedBorderColor: cores.secundaria,
                fieldWidth: 50,
                fieldHeight: 60,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                showFieldAsBox: true,
                keyboardType: TextInputType.number,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cores.secundaria,
                ),
                decoration: InputDecoration(contentPadding: EdgeInsets.all(8)),
                borderRadius: BorderRadius.circular(8),
                onSubmit: (String codigo) async {
                  bool valido = await _verificarCodigo(
                    codigo,
                    widget.isCreateCount,
                    widget.email,
                  );
                  if (!valido) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Código inválido. Por favor, tente novamente.',
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.pushNamed(context, "/login");

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Código de Verificação"),
                        content: Text('O código digitado foi $codigo'),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButtonWidget(
                text: "Reenviar Código",
                onPressed: (){}, 
                highSize: ButtonSize.muitoPequeno, 
                widthSize: ButtonSize.pequeno, 
                catColors: cores
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                  "Aguarde 30 segundos antes de solicitar o código novamente",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
