class LoginData {
  LoginData({
    required this.api,
    required this.linkedAccounts,
  });
  factory LoginData.fromJson(Map<String, dynamic> json) {
    // Transform the LinkedAccounts map into the desired format
    final List<Facility> facilities = <Facility>[];
    int index = 0;
    (json['LinkedAccounts'] as Map<String, dynamic>?)
        ?.entries
        .forEach((MapEntry<String, dynamic> entry) {
      facilities.add(
        Facility(
          id: entry.key,
          name: entry.value,
          selected: index == 0,
        ),
      );
      index++;
    });

    return LoginData(
      api: json['Api'] ?? '',
      linkedAccounts: facilities,
    );
  }
  final String api;
  final List<Facility> linkedAccounts;
}

class Facility {
  Facility({
    required this.id,
    required this.name,
    required this.selected,
  });
  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      selected: json['selected'] ?? false,
    );
  }
  final String id;
  final String name;
  final bool selected;
}
