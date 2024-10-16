import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/bloc/historyRhyme/history_rhymes_bloc.dart';
import 'package:rhymer/bloc/rhyme/rhyme_bloc.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/repositories/favorites/favorites_repository.dart';
import 'package:rhymer/repositories/favorites/model/favorite_rhymes.dart';
import 'package:rhymer/repositories/history/history.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';

import 'bloc/favorite/favorite_rhymes_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final config = Configuration.local([HistoryRhymes.schema, FavoriteRhymes.schema,]);
  final realm = Realm(config);
  runApp(RhymerApp(
    realm: realm,
  ));
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({super.key, required this.realm});

  final Realm realm;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
    //fetchRhymes();
  }

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoritesRepository = FavoritesRepository(realm: widget.realm);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RhymeBloc(
              apiClient: RhymerApiClient.create(apiUrl: dotenv.env['API_URL']),
              historyRepository: historyRepository,
              favoritesRepositoryInterface: favoritesRepository,
            ),
          ),
          BlocProvider(
              create: (context) =>
                  HistoryRhymesBloc(historyRepository: historyRepository)
          ),
          BlocProvider(
            create: (context) => FavoriteRhymesBloc(
              favoritesRepository: favoritesRepository,
            ),
          ),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}