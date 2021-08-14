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
            child: StreamBuilder<List<HeroSummarySection>>(
                stream: listAllHeroesBloc.observeHeroList(),
                builder: (context, snapshot) {
                  List<HeroSummarySection> allHeroes =
                      (snapshot.hasData ? snapshot.data : []) ?? [];
                  return ListView.builder(
                    itemBuilder: (listContext, index) => _renderListOfSection(
                      allHeroes[index].heroes,
                      allHeroes[index].sectionName,
                    ),
                    itemCount: allHeroes.length,
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _renderListOfSection(
      List<HeroSummaryOnView> allHeroes, String sectionName) {
    return Column(
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
              .map(
                (hero) => CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 70,
                      height: 140,
                      child: ClipRRect(
                        // child: FittedBox(
                        //   child: ColorFiltered(
                        //       colorFilter: ColorFilter.mode(
                        //         Colors.black.withOpacity(
                        //           hero.highlighted
                        //               ? 0.0
                        //               : 1.0, // 0 = Colored, 1 = Black & White
                        //         ),
                        //         BlendMode.saturation,
                        //       ),
                        //       child: Image.network(hero.iconUrl)),
                        //   fit: BoxFit.cover,
                        // ),
                        child: FittedBox(
                          child: Image.network(hero.iconUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
