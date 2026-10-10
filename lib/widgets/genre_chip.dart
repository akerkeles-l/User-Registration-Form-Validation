import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    const burgundy = Color(0xFF7B302F);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? burgundy : const Color(0xFFFFFAF4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ? burgundy : const Color(0xFFE5D4C2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : burgundy,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
