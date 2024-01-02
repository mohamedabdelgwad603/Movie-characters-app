import 'business_logic/cubit/characters_cubit.dart';
import 'data/models/character_model.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';
import 'presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';
import 'presentation/screens/characters_screen_details.dart';

class AppRoutes {
  CharactersCubit charactersCubit =
      CharactersCubit(CharactersRepository(CharactersWebServices()));
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: ((BuildContext context) => BlocProvider(
                  create: ((context) => charactersCubit),
                  child: const CharactersScreen(),
                )));
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: ((BuildContext context) => BlocProvider(
                  create: (context) => CharactersCubit(
                      CharactersRepository(CharactersWebServices())),
                  child: CharactersDetailsScreen(
                    character: character,
                  ),
                )));
    }
  }
}
