import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Album.dart';
import '../models/Artist.dart';

const accessToken ="BQD24Dz7Rjj4Yxp3iANEcqtmKxtZKSS03CJqwEQzxFAwW94nL2yqFINJfoMwxHCjMl1_At-qv_L91mJtb8EuP4OonjFqbygOUk0QfCGZvh8cJBH8P8U";
const urlApiSpotifyDomain = "api.spotify.com";
const urlApiSpotifyNew = "v1/browse/new-releases";
const urlApiSpotifyDetail = "v1/albums/";
const urlApiSpotifyArtiste = "v1/artists/";


class AlbumProvider {
  Future<List<Album>> fetchAlbum() async {
    var url = Uri.https(urlApiSpotifyDomain, urlApiSpotifyNew);
    var data = json.decode(
        (await http.get(
          url,
         headers: {'Authorization': 'Bearer $accessToken'}))
            .body);
    List<Album> liste = [];
    for (final album in data['albums']['items']) {
      liste.add(Album.fromJson(album));
    }
    return liste;
  }


  Future<Album> fetchAlbumDetail(id) async {
    var url = Uri.https(urlApiSpotifyDomain, urlApiSpotifyDetail+id);
    print(id);
    var data = json.decode(
        (await http.get(
          url,
         headers: {'Authorization': 'Bearer $accessToken'}))
            .body);
    
  
    Album detail = Album.fromJson(data);
    return detail;
    }
}

class ArtistProvider{
  Future<Artist> fetchArtiste(id) async {
    var url= Uri.https(urlApiSpotifyDomain,urlApiSpotifyArtiste+id);
    print(id);
    var data = json.decode(
      (
        await http.get(
          url,
          headers: {'Authorization':'Bearer $accessToken'})).body);
    
    Artist artiste = Artist.fromJson(data);
    return artiste;
  }
}