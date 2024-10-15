import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/repositories/favorites/model/favorite_rhymes.dart';
import 'package:rhymer/ui/ui.dart';

import '../../../bloc/favorite/favorite_rhymes_bloc.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteRhymesBloc>(context).add(LoadFavoriteRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Избранное'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<FavoriteRhymesBloc, FavoriteRhymesState>(
            builder: (context, state) {
              if (state is FavoriteRhymesLoaded) {
                return SliverList.builder(
                  itemCount: state.rhymes.length,
                  itemBuilder: (context, index) {
                    final rhyme = state.rhymes[index];
                    return RhymeListCard(
                      isFavorite: true,
                      rhyme: rhyme.favoriteWord,
                      sourceWord: rhyme.queryWord,
                      onTap: () {
                        _toggleFavoriteRhyme(context, rhyme);
                      },
                    );
                  },
                );
              }
              return const SliverFillRemaining(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _toggleFavoriteRhyme(BuildContext context, FavoriteRhymes rhyme) {
    BlocProvider.of<FavoriteRhymesBloc>(context)
        .add(ToggleFavoriteRhyme(rhyme));
  }
}


// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
//
// import '../../../ui/ui.dart';
//
// @RoutePage()
// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           const SliverAppBar(
//             centerTitle: true,
//             snap: true,
//             floating: true,
//             title: Text('Избранное'),
//             elevation: 0,
//             surfaceTintColor: Colors.transparent,
//           ),
//           const SliverToBoxAdapter(child: SizedBox(height: 16)),
//           SliverList.builder(
//               itemBuilder: (context, index) => const RhymeListCard(
//                     isFavorite: true,
//                     rhyme: 'Рифма',
//                     sourceWord: 'Слово',
//                   ))
//         ],
//       ),
//     );
//   }
// }
