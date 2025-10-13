import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Meta.dart';


class MetasPageView extends StatelessWidget {
  final List<Metas> metas;
  final CatColors cor;

  const MetasPageView({super.key, required this.metas, required this.cor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Tamanho do PageView
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: metas.length,
        itemBuilder: (context, index) {
          final meta = metas[index];
          return _metaCard(meta);
        },
      ),
    );
  }

 Widget _metaCard(Metas meta) {
      return Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cor.corTerciaria,width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cor.corTerciaria.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              meta.nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'R\$ ${meta.gastoLimite.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'LondrinaSolid',
                color: Color(0x93888888)
                ),
            ),
            SizedBox(height: 10),
            Text(
              'R\$ ${meta.gastoLimite.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'LondrinaSolid',
                color: Colors.black
                ),
            )

            
          ],  
        ),
      );

  }
}