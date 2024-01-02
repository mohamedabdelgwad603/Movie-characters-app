// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/models/episode_model.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;
  const CharactersRepository(
    this.charactersWebServices,
  );

  Future<CharactersModel> getAllCharacters() async {
    Map<String, dynamic> characters =
        await charactersWebServices.getAllCharacters();

    return CharactersModel.fronJson(characters);
  }

  Future<Episode> getEpisode() async {
    Map<String, dynamic> episode = await charactersWebServices.getEpisode();
    return Episode.fromJson(episode);
  }
}
