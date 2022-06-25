import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LiveChannel {
  final String? id;
  final String? title;
  final String? description;
  final String? url;
  final String? image;
  bool isFavorite;

  LiveChannel(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.image,
      this.isFavorite = false});
}

class LiveChannelsProvider with ChangeNotifier {
  List<LiveChannel> _liveChannels = [
    // LiveChannel(
    //     id: '1',
    //     title: 'Al Nas',
    //     description: 'Quran Kareem',
    //     url: '',
    //     image:
    //         'https://yt3.ggpht.com/ytc/AKedOLRcVSp6rNtROgNJqld7UX3ZECvfWZX_76TYWj0b=s900-c-k-c0x00ffffff-no-rj',
    //     isFavorite: false),
    // LiveChannel(
    //     id: '2',
    //     title: 'MBC',
    //     description: 'entertainment',
    //     url: '',
    //     image: 'https://cdn.sat.tv/wp-content/uploads/2017/03/MBC1.png',
    //     isFavorite: false),
    // LiveChannel(
    //     id: '3',
    //     title: 'DMC',
    //     description: 'Movies',
    //     url: '',
    //     image: 'https://photos.live-tv-channels.org/tv-logo/eg-dmc-8086.jpg',
    //     isFavorite: false),
    // LiveChannel(
    //     id: '4',
    //     title: 'ON TV',
    //     description: 'Sports',
    //     url: '',
    //     image: 'https://television-live.com/uploads/posts/g43g43gs34gf3fef.jpg',
    //     isFavorite: false),
    // LiveChannel(
    //     id: '5',
    //     title: 'Rotana',
    //     description: 'Films',
    //     url: '',
    //     image:
    //         'https://mostaql.hsoubcdn.com/uploads/thumbnails/368396/129740/d1a635c0-7ea2-45b7-9569-74c0ca56cc92.png',
    //     isFavorite: false),
    // LiveChannel(
    //     id: '6',
    //     title: 'BBC',
    //     description: 'News',
    //     url: '',
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/en/thumb/f/ff/BBC_News.svg/2560px-BBC_News.svg.png',
    //     isFavorite: false),
  ];

  List<LiveChannel> get liveChannels => [..._liveChannels];

  Future<void> addLiveChannel(LiveChannel liveChannel) async {
    final id = DateTime.now().toString();
    var url = Uri.parse(
        'https://etfarag-52dc8-default-rtdb.asia-southeast1.firebasedatabase.app/livechannels.json');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'title': liveChannel.title,
            'description': liveChannel.description,
            'image': liveChannel.image,
            'url': liveChannel.url
          }));

      _liveChannels.insert(
          0,
          LiveChannel(
            id: jsonDecode(response.body)['name'],
            title: liveChannel.title,
            description: liveChannel.description,
            image: liveChannel.image,
            url: liveChannel.url,
          ));
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  Future fetchAndSetLive() async {
    var url = Uri.parse(
        'https://etfarag-52dc8-default-rtdb.asia-southeast1.firebasedatabase.app/livechannels.json');

    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.get(url);
      final data = jsonDecode(response.body) as Map;
      List<LiveChannel> fetched = [];

      data.forEach((key, value) {
        print(prefs.getBool(key));
        fetched.add(LiveChannel(
            id: key,
            title: value['title'],
            description: value['description'],
            image: value['image'],
            url: value['url'],
            isFavorite: prefs.getBool(key) ?? false));
      });
      _liveChannels = fetched;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  void toggleFavorite(String id) async {
    final liveChannel = _liveChannels.firstWhere((element) => element.id == id);
    final prefs = await SharedPreferences.getInstance();

    liveChannel.isFavorite = !liveChannel.isFavorite;
    print(id);
    await prefs.setBool(id, liveChannel.isFavorite);
    notifyListeners();
  }
}
