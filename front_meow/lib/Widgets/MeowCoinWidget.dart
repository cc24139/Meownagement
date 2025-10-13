import 'package:flutter/material.dart';

class MeowcoinWidget extends StatelessWidget {
  final int saldo;
  final Color corFundo;
  final Color corTexto;

  const MeowcoinWidget({
    super.key,
    required this.saldo,
    this.corFundo = Colors.transparent,
    this.corTexto = Colors.white,
  });

  @override
  Widget build(BuildContext context){
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: corFundo,
          border: Border.all(
            color: corTexto, 
            width: 2
            ),
          borderRadius: BorderRadius.circular(10),
        ),child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
          const SizedBox(width: 6),
          Text(
            "${saldo} MC",
            style: TextStyle(
              color: corTexto,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
      
  