import 'package:equatable/equatable.dart';

import '../../api/models/rhymes.dart';
import '../../repositories/favorites/model/favorite_rhymes.dart';

// Состояния блока рифм
sealed class RhymeState extends Equatable {
  const RhymeState();

  @override
  List<Object> get props => [];
}

class RhymeInitial extends RhymeState {}

class RhymeLoading extends RhymeState {}

final class RhymeLoaded extends RhymeState {
  const RhymeLoaded({
    required this.rhymes,
    required this.query,
    required List<FavoriteRhymes> favoriteRhymes,
  }) : _favoriteRhymes = favoriteRhymes;

  final String query;
  final Rhymes rhymes;
  final List<FavoriteRhymes> _favoriteRhymes;

  bool isFavorite(String rhyme) {
    return _favoriteRhymes
        .where((e) => e.favoriteWord == rhyme && e.queryWord == query)
        .isNotEmpty;
  }

  @override
  List<Object> get props =>
      super.props..addAll([rhymes, query, _favoriteRhymes]);

  RhymeLoaded copyWith({
    String? query,
    Rhymes? rhymes,
    List<FavoriteRhymes>? favoriteRhymes,
  }) {
    return RhymeLoaded(
      query: query ?? this.query,
      rhymes: rhymes ?? this.rhymes,
      favoriteRhymes: favoriteRhymes ?? _favoriteRhymes,
    );
  }
}

class RhymeError extends RhymeState {
  const RhymeError(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
