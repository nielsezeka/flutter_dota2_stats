import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_index.dart';
import 'list_all_heroes_bloc.dart';

class ListAllHeroes extends StatefulWidget {
  const ListAllHeroes({Key? key}) : super(key: key);

  @override
  _ListAllHeroesState createState() => _ListAllHeroesState();
}

class _ListAllHeroesState extends State<ListAllHeroes> {
  ListAllHeroesBloc listAllHeroesBloc = ListAllHeroesBloc();
  late ThemeData currentTheme;
  @override
  Widget build(BuildContext context) {
    currentTheme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: currentTheme.backgroundColor,
      child: Column(
        children: [
          MySearchBar(
            onTextChanged: (String value) {
              listAllHeroesBloc.acceptSearchTerm(value);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<List<HeroSummarySection>>(
                  stream: listAllHeroesBloc.observeHeroList(),
                  builder: (context, snapshot) {
                    List<HeroSummarySection> allHeroes =
                        (snapshot.hasData ? snapshot.data : []) ?? [];
                    return Column(
                      children: allHeroes
                          .map((e) => _renderListOfSection(
                                e.heroes,
                                e.sectionName,
                              ))
                          .toList(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderListOfSection(
    List<HeroSummaryOnView> allHeroes,
    String sectionName,
  ) {
    return RepaintBoundary(
      child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sectionName,
                textAlign: TextAlign.start,
                style: currentTheme.textTheme.headline6,
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: allHeroes
                .map((hero) => OpenContainer(closedBuilder: (context, action) {
                      return ClipRRect(
                        // borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 70,
                          height: 140,
                          child: ClipRRect(
                            child: ExtendedImage.network(
                              hero.iconUrl,
                              width: 70,
                              height: 140,
                              fit: BoxFit.cover,
                              cache: true,
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(8.0),
                              // ),
                            ),
                          ),
                        ),
                      );
                    }, openBuilder: (context, action) {
                      return Material(
                        child: DetailHero(heroID: hero.id),
                      );
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
