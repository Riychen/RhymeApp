import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/repositories/history/history.dart';

import '../../api/api.dart'; // Подключение API клиента
import '../../repositories/favorites/favorites_repository_interface.dart';
import 'rhyme_event.dart';
import 'rhyme_state.dart';

// Логика блока для поиска рифм
class RhymeBloc extends Bloc<RhymeEvent, RhymeState> {
  RhymeBloc({
    required RhymerApiClient apiClient,
    required HistoryRepositoryInterface historyRepository,
    required FavoritesRepositoryInterface favoritesRepositoryInterface,
  })  : _historyRepository = historyRepository,
        _favoritesRepository = favoritesRepositoryInterface,
        _apiClient = apiClient,
        super(RhymeInitial()) {
    on<FetchRhymes>(_onFetchRhymes);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;
  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _onFetchRhymes(
      FetchRhymes event, Emitter<RhymeState> emit) async {
    try {
      emit(RhymeLoading());

      final rhymesList = await _apiClient.getRhymesList({"word": event.word});
      final rhymes = Rhymes(words: rhymesList);
      final historyRhymes = rhymes.toHistory(event.word);
      await _historyRepository.setRhymes(historyRhymes);
      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(
        RhymeLoaded(
          rhymes: rhymes,
          query: event.word,
          favoriteRhymes: favoriteRhymes,
        ),
      );
    } catch (e) {
      emit(RhymeError('Ошибка при получении рифм: $e'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhymes event,
    Emitter<RhymeState> emit,
  ) async {
    try {
      final prevState = state;
      if (prevState is! RhymeLoaded) {
        log('state is not RhymesListLoaded');
        return;
      }
      await _favoritesRepository.createOrDeleteRhymes(
        event.rhymes.toFavorite(event.query, event.favoriteWord),
      );
      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(prevState.copyWith(favoriteRhymes: favoriteRhymes));
    } catch (e) {
      emit(RhymeError(e));
    } finally {
      event.completer?.complete();
    }
  }
}
