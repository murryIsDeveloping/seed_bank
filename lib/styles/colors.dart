import 'package:flutter/material.dart';

class Pallette {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color shade;
  final Color shadeAccent;

  const Pallette({
    @required this.primary,
    @required this.secondary,
    @required this.accent,
    @required this.shade,
    @required this.shadeAccent,
  });
}

const _pallette1 = Pallette(
  primary: Color(0xFF1A936F),
  secondary: Color(0xFF114B5F),
  accent: Color(0xFF88D498),
  shade: Color(0xFFC6DABF),
  shadeAccent: Color(0xFFF3E9D2),
);

const _pallette2 = Pallette(
  primary: Color(0xFF2A9D8F),
  secondary: Color(0xFF264653),
  accent: Color(0xFFE9C46A),
  shade: Color(0xFFF4A261),
  shadeAccent: Color(0xFFE76F51),
);

const pallette = _pallette1;
