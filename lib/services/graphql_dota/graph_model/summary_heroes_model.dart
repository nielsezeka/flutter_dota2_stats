class HeroSummary {
  final String? name;
  final String? displayName;
  final List<String> aliases;
  final int id;
  final String? attribute;
  final String? shortName;
  final String? lore;
  final String? hype;
  HeroSummary(
    this.name,
    this.displayName,
    this.aliases,
    this.id,
    this.shortName,
    this.attribute,
    this.lore,
    this.hype,
  );
  HeroSummary.defaultHero({
    this.name = '',
    this.displayName = '',
    this.aliases = const [],
    this.id = -1,
    this.shortName = '',
    this.attribute = '',
    this.lore = '',
    this.hype = '',
  });
  String loreInText() {
    return (this.lore ?? '').replaceAll('<br>', '').replaceAll("\t", "  ");
  }

  String getIconThumb() {
    return 'https://cdn.stratz.com/images/dota2/heroes/${shortName}_vert.png';
  }

  String getIconFull() {
    return 'https://cdn.stratz.com/images/dota2/heroes/${shortName}_model.png';
  }

  String getHeroAttribute() {
    switch (this.attribute) {
      case 'int':
        return 'Intelligence';
      case 'agi':
        return 'Agility';
      case 'str':
        return 'Strength';
      default:
        return this.attribute ?? '';
    }
  }

  HeroSummary.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        displayName = json['displayName'],
        aliases =
            (json['aliases'] as List<Object?>).map((e) => e as String).toList(),
        id = json['id'],
        shortName = json['shortName'],
        attribute = json['stats']['primaryAttribute'],
        lore = json['language']['lore'],
        hype = json['language']['hype'];
}

class AllHeroesSummary {
  List<HeroSummary> allHeroes = [];
  AllHeroesSummary.fromGraphData(List<Object?> graphResponse) {
    allHeroes = graphResponse.map((element) {
      final parsed = element as Map<String, dynamic>;
      return HeroSummary.fromJson(parsed);
    }).toList();
  }
}
