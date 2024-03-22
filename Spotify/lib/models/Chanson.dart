class Chanson {
   String id;
   String title;

  Chanson(this.id, this.title);

  factory Chanson.fromJson(Map<String, dynamic> json) {
    return Chanson(
      json['id'],
      json['name'],
    );
  }
}