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
  
  // 1. Declaramos o Future aqui.
  //    Assumindo que ObterSaldo() retorna um Future<double> ou Future<num>
  late Future<double> _saldoFuture; 
  
  // 2. Removemos o _saldoValor daqui.
  final String _saldoOculto = "Saldo";

  @override
  void initState() {
    super.initState();
    // 3. Inicializamos o Future no initState para ser chamado apenas UMA VEZ.
    _saldoFuture = widget.usuarioServices.ObterSaldo();
  }

  // A função de toggle está correta
  void _toggleVisibilidadeSaldo() {
    setState(() {
      _saldoVisivel = !_saldoVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // A lógica do ícone está correta
    final String iconePath = _saldoVisivel
        ? "../../assets/icons/vetor_olho_aberto.svg" 
        : "../../assets/icons/vetor_olho_fechado.svg";

    // 4. A lógica do 'textoSaldo' foi MOVIDA para dentro do FutureBuilder

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            
            // O GestureDetector está correto
            GestureDetector(
              onTap: _toggleVisibilidadeSaldo, 
              child: SvgPicture.asset(
                iconePath, 
                width: 30,
                height: 30,
                color: widget.cores.complementar,
              ),
            ),
            
            SizedBox(width: 30),
            
            // 5. SUBSTITUÍMOS o Text por um FutureBuilder
            FutureBuilder<double>( 
              future: _saldoFuture, // Ele vai "ouvir" este future
              builder: (context, snapshot) {

                String textoSaldo; // Variável final do texto

                if (snapshot.hasData) {
                  // SUCESSO! Os dados chegaram (snapshot.data)
                  
                  // Criamos o _saldoValor REAL aqui dentro
                  final String _saldoValor = "R\$ ${snapshot.data!.toStringAsFixed(2)}";
                  
                  // Agora aplicamos a lógica de visibilidade
                  textoSaldo = _saldoVisivel 
                      ? _saldoValor 
                      : _saldoOculto;

                } else if (snapshot.hasError) {
                  textoSaldo = "Erro ao carregar"; // Ou podemos usar _saldoOculto
                
                } else {
                  // Enquanto espera (ConnectionState.waiting)
                  textoSaldo = _saldoOculto; // Mostra "Saldo"
                }

                // Retorna o Text com o valor decidido
                return Text(
                  textoSaldo, 
                  style: TextStyle(color: widget.cores.complementar),
                );
              },
            ),
            
            SizedBox(width: 30),
          ],
        ),
      ],
    );
  }
}