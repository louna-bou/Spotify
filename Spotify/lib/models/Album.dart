import './Chanson.dart';
import './Artist.dart';

class Album {
  String id="";
  String name = "";
  String imageUrl = "";
  List<Artist>? artiste;
  List<Chanson>? chansons; // Liste de chansons facultative


  Album(this.name, this.imageUrl, this.id, this.artiste, this.chansons);

  factory Album.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('name') && json.containsKey('images') && json['images'].isNotEmpty && json['images'][0].containsKey('url') && json.containsKey('id')) {
      List<Artist> artistes=[];
      for (var i=0; i<json['artists'].length;i++){
        artistes.add(Artist.fromJson(json['artists'][i]));
      }

      if (json.containsKey('tracks') && json['tracks'] != null && json['tracks'].containsKey('items')) {
        List<dynamic>? tracksJson = json['tracks']?['items']; // Utilisation de ? pour rendre la liste facultative
        List<Chanson>? chansons; // Utilisation de ? pour rendre la liste facultative
        if (tracksJson != null) {
          chansons = tracksJson.map((trackJson) => Chanson.fromJson(trackJson)).toList();
        }
        return Album(json['name'], json['images'][0]['url'], json['id'], artistes, chansons);
      } else {
        return Album(json['name'], json['images'][0]['url'], json['id'], artistes, null);
      }
    } else {
      throw ArgumentError('Invalid JSON format for Album');
    }
  }

  @override
  String toString() {
    return 'name: $name, url: $imageUrl, id : $id, artiste : $artiste';
  }
}
