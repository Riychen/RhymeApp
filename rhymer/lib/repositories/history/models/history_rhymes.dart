import 'package:realm/realm.dart';

part 'history_rhymes.realm.dart';

@RealmModel()
class _HistoryRhymes {
  @PrimaryKey()
  late String id;
  late String word;
  late List<String> words;

  // @override
  // String toString() => '_HistoryRhymes(id: $id, words: $words';

}