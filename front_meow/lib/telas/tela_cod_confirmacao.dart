import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:front_meow/models/usuario.dart';
import 'package:front_meow/services/UsuarioServices.dart';

class TelaCodConfirmacao extends StatefulWidget {

  final String email;
  final bool isCreateCount;
  const TelaCodConfirmacao({super.key, required this.email, required this.isCreateCount});

  @override
  State<TelaCodConfirmacao> createState() => _TelaCodConfirmacaoState(email: email, isCreateCount: isCreateCount);


Future<void> _enviarCodigo() async {

}
Future<bool> _verificarCodigo(String codigo,bool isCreateCount,String email) async {
  try {
    var httpUsuarios = UsuarioServices();
    if (isCreateCount) {
      var criou = await httpUsuarios.ConfirmarEmailUsuario(codigo, email);
      return criou;
    }
    else {
      var resetou = await httpUsuarios.ConfirmarEsquecerSenhaUsuario(codigo, email);
      return resetou;
    }
  } catch (e) {
    return false;
  }
  }
}

class _TelaCodConfirmacaoState extends State<TelaCodConfirmacao> {
  final String email;
  final bool isCreateCount;

  _TelaCodConfirmacaoState({required this.email, required this.isCreateCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmação por Email",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Londrina",
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              fieldWidth: 30,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              showFieldAsBox: true,
              onSubmit: (String codigo) {
                TelaCodConfirmacao tela = new TelaCodConfirmacao(email: widget.email, isCreateCount: widget.isCreateCount);
                bool valido = tela._verificarCodigo(codigo, widget.isCreateCount, widget.email) as bool;
                if (!valido) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Código inválido. Por favor, tente novamente.'),
                    ),
                  );
                  return;
                }
                else{
                  if (widget.isCreateCount) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    Navigator.pushReplacementNamed(context, '/resetar_senha', arguments: widget.email);
                  }
                }
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
            TextButton(
              onPressed: () {
               // _enviarCodigo();
              },
              child: Text("Reenviar Código"),
            ),
            SizedBox(
              width: 200,
              child: Text(
                "Aguarde 30 segundos antes de solicitar o código novamente",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                child: Text("Finalizar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
