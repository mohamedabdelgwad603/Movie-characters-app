import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(characterDetailsScreen, arguments: character),
      child: GridTile(
        footer: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColors.myGrey.withOpacity(.9),
            ),
            alignment: Alignment.center,
            child: Text(
              character!.name!,
              style: TextStyle(fontSize: 25.sp, color: MyColors.myWhite),
            ),
          ),
        ),
        child: Hero(
          tag: character!.id!,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: MyColors.myWhite,
                borderRadius: BorderRadius.circular(5)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/load.gif',
              image: character!.image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
