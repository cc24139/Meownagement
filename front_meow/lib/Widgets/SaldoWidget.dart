import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/colors/colors.dart';



class SaldoWidget extends StatefulWidget {
  final CatColors cores;
  const SaldoWidget({Key? key, required this.cores}) : super(key: key);

  @override
  _SaldoWidgetState createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<SaldoWidget> {
  
  bool _saldoVisivel = false;

  final String _saldoValor = '';
  final String _saldoOculto = "Saldo";


  // 2. Função para inverter o estado (toggle)
  void _toggleVisibilidadeSaldo() {
    // setState notifica o Flutter para "redesenhar" a tela com os novos valores
    setState(() {
      _saldoVisivel = !_saldoVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // 3. Definimos qual ícone e qual texto usar ANTES do return
    final String iconePath = _saldoVisivel
        ? "../../assets/icons/vetor_olho_aberto.svg" // (ASSUMINDO QUE VOCÊ TEM ESSE ARQUIVO)
        : "../../assets/icons/vetor_olho_fechado.svg";

    final String textoSaldo = _saldoVisivel 
        ? _saldoValor 
        : _saldoOculto; // Ou "Saldo", se preferir

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            
            // 4. Transformamos o ícone em um "botão"
            GestureDetector(
              onTap: _toggleVisibilidadeSaldo, // Chama a função ao tocar
              child: SvgPicture.asset(
                iconePath, // Usa a variável do ícone
                width: 30,
                height: 30,
                color: widget.cores.complementar,
              ),
            ),
            
            SizedBox(width: 30),
            
            // 5. O texto agora é dinâmico
            Text(
              textoSaldo, // Usa a variável de texto
              style: TextStyle(color: widget.cores.complementar),
            ),
            
            SizedBox(width: 30),
          ],
        ),
      ],
    );
  }
}
