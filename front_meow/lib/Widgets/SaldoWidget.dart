import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import '../locator.dart';

class SaldoWidget extends StatefulWidget {
  final CatColors cores;
  final dynamic usuarioServices = locator<UsuarioServices>();
  SaldoWidget({Key? key, required this.cores}) : super(key: key);

  @override
  _SaldoWidgetState createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<SaldoWidget> {
  bool _saldoVisivel = false;
  late Future<double> _saldoFuture; 
  final String _saldoOculto = "Saldo";

  @override
  void initState() {
    super.initState();
    _saldoFuture = widget.usuarioServices.ObterSaldo();
  }

  void _toggleVisibilidadeSaldo() {
    setState(() {
      _saldoVisivel = !_saldoVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String iconePath = _saldoVisivel
        ? "assets/icons/vetor_olho_aberto.svg" 
        : "assets/icons/vetor_olho_fechado.svg";

    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.cores.corTerciaria,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _toggleVisibilidadeSaldo,
            child: SvgPicture.asset(
              iconePath,
              width: 20,
              height: 20,
              color: widget.cores.complementar==Colors.white ? Colors.black : widget.cores.complementar,
            ),
          ),
          const SizedBox(width: 8),
          FutureBuilder<double>(
            future: _saldoFuture,
            builder: (context, snapshot) {
              String textoSaldo;

              if (snapshot.hasData) {
                final String _saldoValor = "R\$ ${snapshot.data!.toStringAsFixed(2)}";
                textoSaldo = _saldoVisivel ? _saldoValor : _saldoOculto;
              } else if (snapshot.hasError) {
                textoSaldo = "Erro ao carregar";
              } else {
                textoSaldo = _saldoOculto;
              }

              return Text(
                textoSaldo,
                style: TextStyle(
                  color: widget.cores.complementar==Colors.white ? Colors.black : widget.cores.complementar,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}