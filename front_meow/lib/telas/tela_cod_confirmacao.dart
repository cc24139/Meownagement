import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Digite o código de 6 dígitos enviado para:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              fieldWidth: 40,
              fieldHeight: 50,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              showFieldAsBox: true,
              keyboardType: TextInputType.number,
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
                if (widget.isCreateCount) {
                    Navigator.pushReplacementNamed(context, '/login');
                } else {
                    Navigator.pushReplacementNamed(
                      context,
                      '/resetar_senha',
                      arguments: widget.email,
                    );
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
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                // _enviarCodigo();
              },
              child: Text(
                "Reenviar Código",
                style: TextStyle(
                  color: Color(0xFF512DA8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
    );
  }
}
