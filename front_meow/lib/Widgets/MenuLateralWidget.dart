import 'package:flutter/material.dart';
import 'package:front_meow/rotas.dart';

class Menulateralwidget extends StatelessWidget {
  const Menulateralwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF1F1F1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 50),

          _buildDrawerItem(
            icon: Icons.home,
            text: 'Tela Inicial',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.inicial);
            },
          ),
          _buildDrawerItem(
            icon: Icons.emoji_events,
            text: 'Criar Meta',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.criarMeta);
            },
          ),
          _buildDrawerItem(
            icon: Icons.inventory_2,
            text: 'Gaveta',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.gaveta);
            },
          ),
          _buildDrawerItem(
            icon: Icons.attach_money,
            text: 'Transações',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.transacoes);
            },
          ),
          _buildDrawerItem(
            icon: Icons.pets,
            text: 'Meus gatos',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.galeria);
            },
          ),
          _buildDrawerItem(
            icon: Icons.person_outline,
            text: 'Perfil',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.perfil);
            },
          ),
          _buildDrawerItem(
            icon: Icons.search,
            text: 'Usuários',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.amizades);
            },
          ),
          _buildDrawerItem(
            icon: Icons.move_to_inbox,
            text: 'Caixa de Gatos',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.gacha);
            },
          ),

          const Divider(color: Colors.black26),

          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Deslogar',
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRotas.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
