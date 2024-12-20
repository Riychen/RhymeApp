import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({
    super.key,
    required this.rhymes,
    required this.word,
  });

  final List<String> rhymes;
  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppContainer(
      padding: const EdgeInsets.all(16),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              word,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 18
              ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Text(
                rhymes.asMap().entries.map((e) {
                  final sb = StringBuffer();
                  sb.write(e.value);
                  if (e.key != rhymes.length - 1) {
                    sb.write(',  ');
                  }
                  return sb.toString();
                }).join(),
                overflow: TextOverflow.fade,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: theme.hintColor.withOpacity(0.4)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
