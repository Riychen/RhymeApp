import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key, required this.onTap, required this.controller,
  });

  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.hintColor.withOpacity(0.1)),
        child: Row(
          children: [
            const Icon(Icons.search_rounded),
            const SizedBox(width: 12),
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return  Text(
                  controller.text.isEmpty ? 'Поиск...' : controller.text,
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.hintColor.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}