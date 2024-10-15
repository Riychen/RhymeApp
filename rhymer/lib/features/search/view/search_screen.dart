import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/ui/ui.dart';

import '../../../bloc/favorite/favorite_rhymes_bloc.dart';
import '../../../bloc/historyRhyme/history_rhymes_bloc.dart';
import '../../../bloc/rhyme/rhyme_bloc.dart';
import '../../../bloc/rhyme/rhyme_event.dart';
import '../../../bloc/rhyme/rhyme_state.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          title: const Text('Rhymer'),
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SearchButton(
              controller: _searchController,
              onTap: () => _showSearchBottomSheet(context),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
            builder: (context, state) {
              if (state is! HistoryRhymesLoaded) return const SizedBox();
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.rhymes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final rhymes = state.rhymes[index];
                    return RhymeHistoryCard(
                      rhymes: rhymes.words,
                      word: rhymes.word,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocConsumer<RhymeBloc, RhymeState>(
          listener: _handleRhymeState,
          builder: (context, state) {
            if (state is RhymeLoaded) {
              final rhymesModel = state.rhymes;
              final rhymes = rhymesModel.words;
              return SliverList.builder(
                itemCount: rhymes.length,
                itemBuilder: (context, index) {
                  final rhyme = rhymes[index];
                  return RhymeListCard(
                    rhyme: rhyme,
                    isFavorite: state.isFavorite(rhyme),
                    onTap: () =>
                        _toggleFavorite(context, rhymesModel, state, rhyme),
                  );
                },
              );
            }
            if (state is RhymeInitial) {
              return const SliverFillRemaining(
                child: RhymeListInitialBanner(),
              );
            }
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    Rhymes rhymesModel,
    RhymeLoaded state,
    String currentRhyme,
  ) async {
    final rhymeBloc = BlocProvider.of<RhymeBloc>(context);
    final favoriteRhymesBloc = BlocProvider.of<FavoriteRhymesBloc>(context);

    final completer = Completer();
    rhymeBloc.add(
      ToggleFavoriteRhymes(
        rhymes: rhymesModel,
        query: state.query,
        favoriteWord: currentRhyme,
        completer: completer,
      ),
    );
    await completer.future;
    favoriteRhymesBloc.add(LoadFavoriteRhymes());
  }

  void _handleRhymeState(
    BuildContext context,
    RhymeState state,
  ) {
    if (state is RhymeLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final bloc = BlocProvider.of<RhymeBloc>(context);
    final query = await showModalBottomSheet<String>(
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 90),
        child: SearchRhymeBottomSheet(
          controller: _searchController,
        ), // Передаем apiClient
      ),
    );

    if (query?.isNotEmpty ?? false) {
      bloc.add(FetchRhymes(query!));
    }
  }
}

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rhymer/bloc/rhyme/rhyme_bloc.dart';
// import 'package:rhymer/bloc/rhyme/rhyme_event.dart';
// import 'package:rhymer/repositories/history/history.dart';
//
// import '../../../bloc/historyRhyme/history_rhymes_bloc.dart';
// import '../../../bloc/rhyme/rhyme_state.dart';
// import '../../../ui/ui.dart';
// import '../widgets/widgets.dart';
//
// @RoutePage()
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({
//     super.key,
//   });
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           centerTitle: true,
//           pinned: true,
//           snap: true,
//           floating: true,
//           title: const Text('Rhymer'),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.transparent,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: SearchButton(
//               controller: _searchController,
//               onTap: () => _showSearchBottomSheet(context, theme),
//             ),
//           ),
//         ),
//         const SliverToBoxAdapter(child: SizedBox(height: 16)),
//         SliverToBoxAdapter(
//           child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
//             builder: (context, state) {
//               if (state is! HistoryRhymesLoaded) return const SizedBox();
//               return SizedBox(
//                 height: 120,
//                 child: ListView.separated(
//                   padding: const EdgeInsets.only(left: 16),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: state.rhymes.length,
//                   separatorBuilder: (context, index) =>
//                   const SizedBox(width: 20),
//                   itemBuilder: (context, index) {
//                     final rhymes = state.rhymes[index];
//                     return RhymeHistoryCard(
//                         word: rhymes.word,
//                         rhymes: rhymes.words);
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//         const SliverToBoxAdapter(child: SizedBox(height: 16)),
//         BlocConsumer<RhymeBloc, RhymeState>(
//           listener: (context, state) {
//             _handleRhymeState(context, state);
//           },
//           builder: (context, state) {
//             if (state is RhymeLoaded) {
//               final rhymes = state.rhymes.words; // Доступ к списку рифм
//               if (rhymes.isEmpty) {
//                 return const SliverToBoxAdapter(
//                   child: Center(child: Text('Рифмы не найдены')),
//                 );
//               }
//               return SliverList.builder(
//                 itemCount: rhymes.length,
//                 itemBuilder: (context, index) =>
//                     RhymeListCard(
//                       rhyme: rhymes[index], // Здесь отображаем рифму из списка
//                     ),
//               );
//             } else if (state is RhymeError) {
//               return SliverToBoxAdapter(
//                 child: Center(child: Text(state.message)),
//               );
//             }
//             if (state is RhymeInitial) {
//               return const SliverFillRemaining(
//                 child: RhymeListInitialBanner(),
//               );
//             }
//
//             return const SliverFillRemaining(
//               child: Center(child: CircularProgressIndicator()),
//             );
//           },
//         )
//       ],
//     );
//   }
//
//   void _handleRhymeState( BuildContext context, RhymeState state) {
//     if (state is RhymeLoaded) {
//       BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
//     }
//   }
//
//   Future<void> _showSearchBottomSheet(BuildContext context,
//       ThemeData theme) async {
//     final bloc = BlocProvider.of<RhymeBloc>(context);
//     final query = await showModalBottomSheet<String>(
//       isScrollControlled: true,
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) =>
//           Padding(
//             padding: const EdgeInsets.only(top: 90),
//             child: SearchRhymeBottomSheet(
//               controller: _searchController,
//             ), // Передаем apiClient
//           ),
//     );
//
//     if (query?.isNotEmpty ?? false) {
//       bloc.add(FetchRhymes(query!));
//     }
//   }
// }
