import 'package:etfarag/desktop_screens/desktop_video_player.dart';
import 'package:etfarag/providers/movies_provider.dart';
import 'package:etfarag/screens/add_live_screen.dart';
import 'package:etfarag/screens/add_movie_screen.dart';
import 'package:etfarag/screens/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/live_channel_provider.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({Key? key}) : super(key: key);

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddLiveChannel.id);
                },
                icon: Icon(Icons.add_circle_rounded)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddMovie.id);
                },
                icon: Icon(Icons.add_box_sharp))
          ],
          title: Text(
            'Etfarag',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Live Channels',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: context
                              .read<LiveChannelsProvider>()
                              .fetchAndSetLive(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Consumer<LiveChannelsProvider>(
                                child: Center(
                                  child:
                                      Text('No Live Channels available now!!!'),
                                ),
                                builder: ((context, lcp, ch) {
                                  if (lcp.liveChannels.isEmpty) {
                                    return ch!;
                                  }
                                  return ListView.builder(
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: lcp.liveChannels.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return DesktopVideoPlayer(
                                                    url: lcp.liveChannels[index]
                                                        .url!);
                                              }));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          lcp
                                                              .liveChannels[
                                                                  index]
                                                              .title!,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            lcp.toggleFavorite(lcp
                                                                .liveChannels[
                                                                    index]
                                                                .id!);
                                                            print(lcp
                                                                .liveChannels[
                                                                    index]
                                                                .isFavorite);
                                                          },
                                                          icon: lcp
                                                                  .liveChannels[
                                                                      index]
                                                                  .isFavorite
                                                              ? Icon(Icons
                                                                  .star_rounded)
                                                              : Icon(Icons
                                                                  .star_border_outlined))
                                                    ],
                                                  ),
                                                  // Text(lcp.liveChannels[index]
                                                  //     .description!),
                                                  Container(
                                                    height: h / 5.5,
                                                    width: w / 2,
                                                    child: Image.network(lcp
                                                        .liveChannels[index]
                                                        .image!),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                }));
                          }),
                    )
                  ],
                )),
            Flexible(
                flex: 40,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 86, 54, 244),
                  child: Column(
                    children: [
                      Text(
                        'Movies',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                        child: FutureBuilder(
                            future: context
                                .read<MovieChannelsProvider>()
                                .fetchAndSetMovies(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Consumer<MovieChannelsProvider>(
                                  child: Center(
                                    child: Text(
                                        'No Mvie Channels available now!!!'),
                                  ),
                                  builder: ((context, mcp, ch) {
                                    if (mcp.movieChannels.isEmpty) {
                                      return ch!;
                                    }
                                    return Align(
                                      child: ListView.builder(
                                          itemCount: mcp.movieChannels.length,
                                          itemBuilder: (context, index) =>
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return DesktopVideoPlayer(
                                                        url: mcp
                                                            .movieChannels[
                                                                index]
                                                            .url!);
                                                  }));
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        mcp.movieChannels[index]
                                                            .title!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                      Text(mcp
                                                          .movieChannels[index]
                                                          .description!),
                                                      Container(
                                                        height: h / 5.5,
                                                        width: w / 3,
                                                        child: Image.network(mcp
                                                            .movieChannels[
                                                                index]
                                                            .image!),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    );
                                  }));
                            }),
                      )
                    ],
                  ),
                )),
            Flexible(
                flex: 30,
                child: Container(
                  color: Color.fromARGB(255, 25, 239, 10),
                )),
          ],
        ));
  }
}
