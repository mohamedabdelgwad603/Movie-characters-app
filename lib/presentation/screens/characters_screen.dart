import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business_logic/cubit/characters_state.dart';
import '../../data/models/character_model.dart';
import '../widgets/charcter_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? characters;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Character>? searchedCharacters = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  _navigateLocallyToSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      setState(() {
        _isSearching = false;
      });
    }));
    setState(() {
      _isSearching = true;
    });
  }

  _clearSearch() {
    setState(() {
      _searchController.text = '';
      searchedCharacters = [];
    });
  }

  Widget _buildSearchTextField() {
    return TextFormField(
      onChanged: (searchedCharacter) {
        setState(() {
          searchedCharacters = characters!.where((character) {
            return character.name!
                .toLowerCase()
                .startsWith(searchedCharacter.trimLeft());
          }).toList();
        });
      },
      controller: _searchController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "find a chrachter",
          hintStyle: TextStyle(fontSize: 15.sp)),
    );
  }

  Center buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'can\'t connect .. check internet',
              style: TextStyle(fontSize: 20, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  BlocBuilder<CharactersCubit, CharactersState> buildBlocBuilderWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          characters = state.characters;
          return Container(
            color: MyColors.myGrey,
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: searchedCharacters!.isEmpty
                  ? characters!.length
                  : searchedCharacters!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 13,
                  crossAxisCount: 2,
                  childAspectRatio: (2 / 3)),
              itemBuilder: (BuildContext context, int index) {
                return CharacterItem(
                    character: searchedCharacters!.isEmpty
                        ? characters![index]
                        : searchedCharacters![index]);
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: _isSearching ? BackButton(color: MyColors.myGrey) : null,
          title: _isSearching
              ? _buildSearchTextField()
              : Text(
                  "Rick and Morty Characters",
                  style: TextStyle(color: MyColors.myGrey, fontSize: 20.sp),
                ),
          backgroundColor: MyColors.myYellow,
          actions: [
            _isSearching
                ? IconButton(
                    onPressed: _clearSearch,
                    icon: Icon(
                      Icons.clear,
                      color: MyColors.myGrey,
                      size: 20.sp,
                    ))
                : IconButton(
                    onPressed: _navigateLocallyToSearch,
                    icon:
                        Icon(Icons.search, color: MyColors.myGrey, size: 20.sp))
          ],
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBlocBuilderWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ),
          ),
        ));
  }
}
