import 'package:dota_2_stats/services/service_index.dart';
import 'package:rxdart/rxdart.dart';

class DetailHeroBloc {
  DotaGraph graph = ServiceFacade.getService<DotaGraph>();
  BehaviorSubject<int> heroId = BehaviorSubject<int>.seeded(-1);
  DetailHeroBloc() {
    if (graph.cachedHeroInfo == null) {
      graph.allHeroesInformation().then(
            (value) => heroId.sink.add(heroId.value!),
          );
    }
  }
  watchHeroInfo(int heroID) {
    heroId.sink.add(heroID);
  }

  Stream<HeroSummary?> observeHero() {
    return heroId.switchMap(
      (heroID) => Stream.value(
        graph.cachedHeroInfo?.firstWhere(
          (element) => element.id == heroID,
          orElse: () => HeroSummary.defaultHero(),
        ),
      ),
    );
  }

  dispose() {
    heroId.close();
  }
}
