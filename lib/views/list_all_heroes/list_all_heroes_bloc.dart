import 'package:collection/collection.dart';
import 'package:dota_2_stats/services/service_index.dart';
import 'package:rxdart/rxdart.dart';

class HeroSummaryOnView {
  final String iconUrl;
  final String name;
  final int id;
  final bool highlighted;

  HeroSummaryOnView({
    required this.iconUrl,
    required this.name,
    required this.id,
    required this.highlighted,
  });
  HeroSummaryOnView copyWith({
    String? iconUrl,
    String? name,
    int? id,
    bool? highlighted,
  }) {
    return HeroSummaryOnView(
      iconUrl: iconUrl ?? this.iconUrl,
      name: name ?? this.name,
      id: id ?? this.id,
      highlighted: highlighted ?? this.highlighted,
    );
  }
}

class HeroSummarySection {
  final String sectionName;
  final List<HeroSummaryOnView> heroes;

  HeroSummarySection({
    required this.sectionName,
    required this.heroes,
  });
}

class ListAllHeroesBloc {
  BehaviorSubject<List<HeroSummarySection>> allHeroesSections =
      BehaviorSubject<List<HeroSummarySection>>.seeded([]);
  BehaviorSubject<String> searchInput = BehaviorSubject<String>.seeded('');
  DotaGraph graph = ServiceFacade.getService<DotaGraph>();
  ListAllHeroesBloc() {
    loadAlInfo();
  }
  void acceptSearchTerm(String searchText) {
    searchInput.sink.add(searchText);
  }

  void loadAlInfo() {
    graph.allHeroesInformation().then((value) {
      allHeroesSections.sink.add(
        groupBy(value, (HeroSummary key) => key.attribute)
            .map((key, value) {
              final sectionname = value[0].getHeroAttribute();
              return MapEntry(
                key,
                HeroSummarySection(
                  heroes: value
                      .map(
                        (e) => HeroSummaryOnView(
                          iconUrl: e.getIconThumb(),
                          name: e.displayName ?? '',
                          id: e.id,
                          highlighted: true,
                        ),
                      )
                      .toList(),
                  sectionName: sectionname,
                ),
              );
            })
            .values
            .toList(),
      );
    });
  }

  Stream<List<HeroSummarySection>> observeHeroList() {
    return Rx.combineLatest2(allHeroesSections, searchInput,
        (List<HeroSummarySection> sections, String searchText) {
      return sections.map((HeroSummarySection section) {
        return HeroSummarySection(
          heroes: section.heroes.map(
            (HeroSummaryOnView hero) {
              final isHighLighted = hero.name.toLowerCase().contains(
                    searchText.toLowerCase(),
                  );
              return hero.copyWith(highlighted: isHighLighted);
            },
          ).toList(),
          sectionName: section.sectionName,
        );
      }).toList();
    });
  }

  dispose() {
    allHeroesSections.close();
  }
}
