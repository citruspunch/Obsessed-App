class Country {
  final String name;
  final String capital;
  final String iso2;
  final String iso3;

  Country({
    required this.name,
    required this.capital,
    required this.iso2,
    required this.iso3,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      capital: json['capital'],
      iso2: json['iso2'],
      iso3: json['iso3'],
    );
  }
}