// ignore_for_file: public_member_api_docs, sort_constructors_first
//part of 'characters_cubit.dart';

import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/models/episode_model.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character>? characters;
  CharactersLoaded({
    required this.characters,
  });
}

class EpisodeLoaded extends CharactersState {
  final Episode episode;

  EpisodeLoaded(this.episode);
}
