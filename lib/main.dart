import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:rota_das_oficinas_test/ui/routes.dart';
import 'package:rota_das_oficinas_test/ui/theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rota das Oficinas',
      theme: challengesTheme,
      routerConfig: router,
    );
  }
}
