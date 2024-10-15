import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../api/models/rhymes.dart';

// События для блока рифм
abstract class RhymeEvent extends Equatable {
  const RhymeEvent();

  @override
  List<Object?> get props => [];
}

// Событие для поиска рифм
class FetchRhymes extends RhymeEvent {
  final String word;

  const FetchRhymes(this.word);

  @override
  List<Object?> get props => super.props..addAll([word]);
}

class ToggleFavoriteRhymes extends RhymeEvent {
  const ToggleFavoriteRhymes({
    required this.rhymes,
    required this.query,
    required this.favoriteWord,
    required this.completer,
  });

  final String query;
  final String favoriteWord;
  final Rhymes rhymes;
  final Completer? completer;

 @override
  List<Object?> get props =>
     super.props..addAll([rhymes, favoriteWord, query, completer]);
}