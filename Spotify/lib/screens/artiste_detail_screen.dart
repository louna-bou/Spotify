import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/Artist.dart';
import '/provider/provider_spotify.dart';
import 'package:cached_network_image/cached_network_image.dart';

// -- detail d'un artiste
class ArtisteDetailScreen extends StatefulWidget {
  final String? id;
  @override
  State<ArtisteDetailScreen> createState() => _ArtisteDetailScreen();

  /// Constructs a [ArtisteDetailScreen]
  const ArtisteDetailScreen({super.key, this.id});
}

class _ArtisteDetailScreen extends State<ArtisteDetailScreen> {
  ArtistProvider artistProvider = ArtistProvider();
  var _artistedetail = Artist("", "", 0, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Artiste Details Screen')),
        body: Center(
            child: Column(children: [
          Text(_artistedetail.name),
          CachedNetworkImage(
            fit: BoxFit.fitHeight,
            imageUrl: _artistedetail.img,
            width: 300,
            height: 300,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text('Nombre de followers : ${_artistedetail.follower.toString()}'),
        ])));
  }

  @override
  void initState() {
    _get();
  }

  void _get() async {
    Artist artist;
    artist = await artistProvider.fetchArtiste(widget.id);
    //print(album);
    setState(() {
      _artistedetail = artist;
    });
  }
}
