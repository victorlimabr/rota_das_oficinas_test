import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

enum ChallengeMenu {
  romanNumbers('Números Romanos', '/roman', Icons.calculate),
  gameOfLife('Jogo da vida', '/game', Icons.gamepad),
  billSplitter('Conta do restaurante', '/splitter', Icons.food_bank);

  final String name;
  final String path;
  final IconData icon;

  const ChallengeMenu(this.name, this.path, this.icon);
}

class ChallengesPage extends StatelessWidget {
  final Widget child;
  final String path;

  const ChallengesPage({
    Key? key,
    required this.child,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationDrawer(
          selectedIndex: ChallengeMenu.values.indexWhere((c) => c.path == path),
          onDestinationSelected: (i) =>
              context.go(ChallengeMenu.values[i].path),
          children: [
            const _ChallengeDrawerHeader(),
            ...ChallengeMenu.values.map(
              (e) => NavigationDrawerDestination(
                icon: Icon(e.icon),
                label: Text(e.name),
              ),
            )
          ],
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _ChallengeDrawerHeader extends StatelessWidget {
  const _ChallengeDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.secondaryContainer,
            ),
            child: const Icon(Icons.code, size: 48),
          ),
          const Text('Desafios - Rota das Oficinas'),
        ],
      ),
    );
  }
}
