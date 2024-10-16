import 'package:flutter/material.dart';

class RhymeListInitialBanner extends StatelessWidget {
  const RhymeListInitialBanner({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('НАЧНИ ИСКАТЬ', style: theme.textTheme.headlineLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Введите слово в строку поиска, \nчтобы найти рифмы',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
