import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/repositories/history/history.dart';

import '../../repositories/favorites/model/favorite_rhymes.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhymes {
  Rhymes({required this.words});

  factory Rhymes.fromJson(Map<String, dynamic> json) => _$RhymesFromJson(json);

  final List<String> words;

  Map<String, dynamic> toJson() => _$RhymesToJson(this);

  HistoryRhymes toHistory(String word) => HistoryRhymes(
      Uuid.v4().toString(),
      word,
      words: words
  );


  FavoriteRhymes toFavorite(String queryWord, String favoriteWord) =>
      FavoriteRhymes(
        Uuid.v4().toString(),
        queryWord,
        favoriteWord,
        DateTime.now(),
        words: words,
      );
}
