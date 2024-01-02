import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character_model.dart';
import '../../data/repository/characters_repository.dart';
import 'characters_state.dart';

//part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character>? characters;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  void getAllCharacters() {
    charactersRepository.getAllCharacters().then((value) {
      characters = value.characters;
      emit(CharactersLoaded(characters: value.characters));
    });
  }

  void getEpisode() {
    charactersRepository.getEpisode().then((episode) {
      emit(EpisodeLoaded(episode));
    });
  }
}
