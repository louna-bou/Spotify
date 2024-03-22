import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/provider/provider_spotify.dart';
import '../models/Album.dart';

// -- les derniers albums (news)
class AlbumNewsScreen extends StatefulWidget {
  @override
  State<AlbumNewsScreen> createState() => _AlbumNewsScreen();

  /// Constructs a [AlbumNewsScreen]
  const AlbumNewsScreen({super.key});
}

class _AlbumNewsScreen extends State<AlbumNewsScreen> {
  AlbumProvider albumProvider = AlbumProvider();
  final List<Album> _listalbums = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album News Screen')),

      // ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _listalbums.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
                    title: Text(_listalbums[index].name),
                    onTap: () =>
                        context.go('/a/albumdetails/${_listalbums[index].id}'),
                    leading: SizedBox(
                        width: 100,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: _listalbums[index].imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ))));
          }),
    );
  }

  @override
  void initState() {
    _get();
  }

  void _get() async {
    List<Album> liste = [];
    liste = await albumProvider.fetchAlbum();
    print(liste);
    setState(() {
      _listalbums.addAll(liste);
    });
  }
}
