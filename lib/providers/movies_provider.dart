import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MovieChannel {
  final String? id;
  final String? title;
  final String? description;
  final String? url;
  final String? image;
  bool isFavorite;

  MovieChannel(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.image,
      this.isFavorite = true});
}

class MovieChannelsProvider with ChangeNotifier {
  List<MovieChannel> _MovieChannels = [
    MovieChannel(
        id: '1',
        title: 'Al Nas',
        description: 'Quran Kareem',
        url: '',
        image:
            'https://yt3.ggpht.com/ytc/AKedOLRcVSp6rNtROgNJqld7UX3ZECvfWZX_76TYWj0b=s900-c-k-c0x00ffffff-no-rj',
        isFavorite: false),
    MovieChannel(
        id: '2',
        title: 'MBC',
        description: 'entertainment',
        url: '',
        image: 'https://cdn.sat.tv/wp-content/uploads/2017/03/MBC1.png',
        isFavorite: false),
    MovieChannel(
        id: '3',
        title: 'DMC',
        description: 'Movies',
        url: '',
        image: 'https://photos.live-tv-channels.org/tv-logo/eg-dmc-8086.jpg',
        isFavorite: false),
    MovieChannel(
        id: '4',
        title: 'ON TV',
        description: 'Sports',
        url: '',
        image: 'https://television-live.com/uploads/posts/g43g43gs34gf3fef.jpg',
        isFavorite: false),
    MovieChannel(
        id: '5',
        title: 'Rotana',
        description: 'Films',
        url: '',
        image:
            'https://mostaql.hsoubcdn.com/uploads/thumbnails/368396/129740/d1a635c0-7ea2-45b7-9569-74c0ca56cc92.png',
        isFavorite: false),
    MovieChannel(
        id: '6',
        title: 'BBC',
        description: 'News',
        url: '',
        image:
            'https://upload.wikimedia.org/wikipedia/en/thumb/f/ff/BBC_News.svg/2560px-BBC_News.svg.png',
        isFavorite: false),
  ];

  List<MovieChannel> get movieChannels => [..._MovieChannels];

  Future<void> addMovie(MovieChannel movieChannel) async {
    final id = DateTime.now().toString();
    var url = Uri.parse(
        'https://etfarag-52dc8-default-rtdb.asia-southeast1.firebasedatabase.app/movieChannels.json');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'title': movieChannel.title,
            'description': movieChannel.description,
            'image': movieChannel.image,
            'url': movieChannel.url
          }));

      _MovieChannels.insert(
          0,
          MovieChannel(
              id: jsonDecode(response.body)['name'],
              title: movieChannel.title,
              description: movieChannel.description,
              image: movieChannel.image,
              url: movieChannel.url,
              isFavorite: false));
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  Future fetchAndSetMovies() async {
    var url = Uri.parse(
        'https://etfarag-52dc8-default-rtdb.asia-southeast1.firebasedatabase.app/movieChannels.json');

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body) as Map;
      List<MovieChannel> fetched = [];

      data.forEach((key, value) {
        fetched.add(MovieChannel(
          id: key,
          title: value['title'],
          description: value['description'],
          image: value['image'],
          url: value['url'],
        ));
      });
      _MovieChannels = fetched;
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }
}
