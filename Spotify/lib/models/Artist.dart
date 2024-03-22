class Artist{
    String id;
   String name;
   int follower;
   String img;


  Artist(this.id, this.name,this.follower,this.img);

 factory Artist.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('name') && json.containsKey('id')) {
      int followers = json['followers']?['total'] ?? 0; 
      String imageUrl = json['images'] != null && json['images'].isNotEmpty ? json['images'][0]['url'] : ''; 
      return Artist(json['id'], json['name'], followers, imageUrl);
    } else {
      throw ArgumentError('Invalid JSON format for Artist');
    }
  }
}
