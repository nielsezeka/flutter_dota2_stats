import 'dart:ui';

import 'package:dota_2_stats/services/service_index.dart';
import 'package:dota_2_stats/views/detail_hero/detail_hero_bloc.dart';
import 'package:flutter/material.dart';

class DetailHero extends StatefulWidget {
  final int heroID;
  const DetailHero({
    Key? key,
    required this.heroID,
  }) : super(key: key);

  @override
  _DetailHeroState createState() => _DetailHeroState();
}

class _DetailHeroState extends State<DetailHero> {
  late ThemeData currentTheme;
  DetailHeroBloc detailHeroBloc = DetailHeroBloc();
  @override
  void initState() {
    super.initState();
    detailHeroBloc.watchHeroInfo(widget.heroID);
  }

  @override
  Widget build(BuildContext context) {
    currentTheme = Theme.of(context);
    return Material(
      child: _renderListData(),
    );
  }

  Widget _renderListData() {
    return StreamBuilder<HeroSummary?>(
        stream: detailHeroBloc.observeHero(),
        builder: (context, snapshot) {
          HeroSummary? hero = snapshot.hasData ? snapshot.data : null;
          if (hero == null) {
            return Container();
          }
          return Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Row(
                    children: [
                      Text(hero.displayName ?? ''),
                    ],
                  ),
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.red,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            hero.getIconThumb(),
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.network(
                              hero.getIconFull(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              hero.loreInText(),
                            ),
                          ],
                        ),
                      ),
                      Container(color: Colors.purple, height: 150.0),
                      Container(color: Colors.green, height: 150.0),
                      Container(color: Colors.green, height: 150.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
