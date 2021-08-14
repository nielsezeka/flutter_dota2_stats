import 'dart:convert';

import 'package:graphql/client.dart';

import 'graph_model/summary_heroes_model.dart';

class DotaGraphConfig {
  static final linkToGraphQL = 'https://api.stratz.com/graphql';
}

class DotaGraph {
  late Link _link;
  late GraphQLClient _client;
  DotaGraph() {
    _link = HttpLink(DotaGraphConfig.linkToGraphQL);
    _client = getGithubGraphQLClient();
  }
  GraphQLClient getGithubGraphQLClient() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  Future<List<HeroSummary>> allHeroesInformation() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        r'''
        {
        constants {
          heroes {
            name
            displayName
            aliases
            id
            shortName
            roles {
              level
              roleId
            }
            abilities {
              abilityId
              gameVersionId
              slot
            }
            stats {
              agilityBase
              agilityGain
              attackAcquisitionRange
              attackAnimationPoint
              attackRange
              attackRate
              attackType
              cMEnabled
              complexity
              enabled
              heroUnlockOrder
              hpBarOffset
              intelligenceBase
              intelligenceGain
              moveSpeed
              moveTurnRate
              mpRegen
              newPlayerEnabled
              primaryAttribute
              startingArmor
              startingDamageMax
              startingDamageMin
              startingMagicArmor
              strengthBase
              strengthGain
              team
              visionDaytimeRange
              visionNighttimeRange
            }
          }
        }
      }
      ''',
      ),
    );
    final QueryResult result = await _client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }
    final foundedData = result.data!['constants']['heroes'] as List<Object?>;

    return AllHeroesSummary.fromGraphData(foundedData).allHeroes;
  }
}
