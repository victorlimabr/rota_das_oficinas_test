import 'package:go_router/go_router.dart';
import 'package:rota_das_oficinas_test/challenge_1/roman_converter_page.dart';
import 'package:rota_das_oficinas_test/challenge_2/game_of_life_page.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_page.dart';
import 'package:rota_das_oficinas_test/ui/challenges_page.dart';

final router = GoRouter(
  initialLocation: ChallengeMenu.romanNumbers.path,
  routes: [
    ShellRoute(
      builder: (_, state, child) => ChallengesPage(
        path: state.location,
        child: child,
      ),
      routes: [
        GoRoute(
          path: ChallengeMenu.romanNumbers.path,
          builder: (context, state) => const RomanConverterPage(),
        ),
        GoRoute(
          path: ChallengeMenu.gameOfLife.path,
          builder: (context, state) => const GameOfLifePage(),
        ),
        GoRoute(
          path: ChallengeMenu.billSplitter.path,
          builder: (context, state) => const BillSplitterPage(),
        ),
      ],
    ),
  ],
);
