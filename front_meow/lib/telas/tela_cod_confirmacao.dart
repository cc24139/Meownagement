import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
class TelaCodConfirmacao extends StatefulWidget {
  const TelaCodConfirmacao({super.key});

  @override
  State<TelaCodConfirmacao> createState() => _TelaCodConfirmacaoState();
}

class _TelaCodConfirmacaoState extends State<TelaCodConfirmacao> {
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSubmit: (String codigo){
                    showDialog(
                        context: context,
                        builder: (context){
                        return AlertDialog(
                            title: Text("Código de Verificação"),
                            content: Text('O código digitado foi $codigo'),
                        );
                        }
                    );
                }, 
            ),
          ],
        ),
      ),
    );
  }
}
