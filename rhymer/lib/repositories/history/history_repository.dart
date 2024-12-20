import 'package:realm/realm.dart';

import 'history.dart';

class HistoryRepository implements HistoryRepositoryInterface {
  HistoryRepository({required this.realm});

  final Realm realm;

  @override
  Future<List<HistoryRhymes>> getRhymesList() async =>
      realm.all<HistoryRhymes>().toList();

  @override
  Future<void> setRhymes(HistoryRhymes rhymes) async =>
      realm.write(() => realm.add(rhymes));

  @override
  Future<void> clear() async =>
      realm.write(() => realm.deleteAll<HistoryRhymes>());
}
