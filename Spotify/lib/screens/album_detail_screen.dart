import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/provider/provider_spotify.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/Album.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  final String? id;
  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreen();

  /// Constructs a [AlbumDetailScreen]
  AlbumDetailScreen({super.key, this.id});
}

class _AlbumDetailScreen extends State<AlbumDetailScreen> {
  AlbumProvider albumProvider = AlbumProvider();
  var _albumdetail = Album("", "", "", [], []);

// -- detail d'un album
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Album Details Screen')),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              CachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl: _albumdetail.imageUrl,
                width: 300,
                height: 300,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Title(color: Colors.black, child: Text(_albumdetail.name)),
              ListView.builder(
                itemCount: _albumdetail.artiste!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const SizedBox(width: 100),
                      onTap: () => context.go(
                          '/a/artistedetails/${_albumdetail.artiste![index].id}'),
                      title: Text(_albumdetail.artiste![index].name));
                },
                shrinkWrap: true,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _albumdetail.chansons!.length,
                itemBuilder: (context, index) {
                  final chanson = _albumdetail.chansons![index];
                  return ListTile(
                    title: Text(chanson.title),
                  );
                },
              ),
            ],
          )),
        ));
  }

  @override
  void initState() {
    _get();
  }

  void _get() async {
    Album album;
    album = await albumProvider.fetchAlbumDetail(widget.id);
    //print(album);
    setState(() {
      _albumdetail = album;
    });
  }
}
