import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/character_model.dart';
import '../../data/models/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_state.dart';

class CharactersDetailsScreen extends StatefulWidget {
  const CharactersDetailsScreen({super.key, required this.character});
  final Character character;

  @override
  State<CharactersDetailsScreen> createState() =>
      _CharactersDetailsScreenState();
}

class _CharactersDetailsScreenState extends State<CharactersDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getEpisode();
    super.initState();
  }

  SliverAppBar buildSliverBar() {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 35.sp,
          )),
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      expandedHeight: 550.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.character.id!,
          child: Image.network(
            widget.character.image!,
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.character.name!,
          style: TextStyle(
              shadows: const [
                Shadow(
                  blurRadius: 15.0,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                )
              ],
              color: MyColors.myWhite,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCharacterInfo('species', widget.character.species!),
                  buildDivider(widthSize * .8),
                  buildCharacterInfo('status', widget.character.status!),
                  buildDivider(widthSize * .8),
                  buildCharacterInfo('gender', widget.character.gender!),
                  buildDivider(widthSize * .8),
                  buildCharacterInfo(
                      'episode', widget.character.episode!.join('')),
                  buildDivider(widthSize * .8),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<CharactersCubit, CharactersState>(
                      builder: ((context, state) {
                    if (state is EpisodeLoaded) {
                      Episode episode = state.episode;
                      return Center(
                        child: DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 25.sp,
                                color: MyColors.myWhite,
                                shadows: const [
                                  Shadow(
                                    blurRadius: 7.0,
                                    color: MyColors.myYellow,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FlickerAnimatedText(episode.episodeName!)
                                ])),
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: MyColors.myYellow,
                      ));
                    }
                  }))
                ],
              ),
            ),
            const SizedBox(
              height: 500,
            )
          ]))
        ],
      ),
    );
  }

  Divider buildDivider(double endIndent) {
    return Divider(
      height: 16,
      endIndent: endIndent,
      thickness: 2.sp,
      color: MyColors.myYellow,
    );
  }

  RichText buildCharacterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: '$title : ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16.sp,
              )),
        ]));
  }
}
