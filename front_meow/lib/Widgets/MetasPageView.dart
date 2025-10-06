import 'package:flutter/material.dart';
import 'package:front_meow/models/meta.dart';


class MetasPageView extends StatelessWidget {
  final List<Metas> metas;

  const MetasPageView({super.key, required this.metas});

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
      

  }
}