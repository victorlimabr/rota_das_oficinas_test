import 'package:flutter/material.dart';

extension ContextTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ContextColors on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  Color get primary => colorScheme.primary;

  Color get onPrimary => colorScheme.onPrimary;

  Color get secondary => colorScheme.secondary;

  Color get secondaryContainer => colorScheme.secondaryContainer;
}

extension ContextTextTheme on BuildContext {
  TextTheme get textTheme => theme.textTheme;

  TextStyle? get titleLarge => textTheme.titleLarge;

  TextStyle? get titleMedium => textTheme.titleMedium;

  TextStyle? get titleSmall => textTheme.titleSmall;

  TextStyle? get bodyLarge => textTheme.bodyLarge;

  TextStyle? get bodyMedium => textTheme.bodyMedium;

  TextStyle? get labelSmall => textTheme.labelSmall;
}
