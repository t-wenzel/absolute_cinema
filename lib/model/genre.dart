class Genre {

  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map){

    return Genre(
      id: map['id'] ?? "id",
      name: map['name'] ?? "name",
    );

  }

}