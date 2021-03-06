import 'package:etfarag/providers/google_signin_provider.dart';
import 'package:etfarag/providers/movies_provider.dart';
import 'package:etfarag/screens/add_live_screen.dart';
import 'package:etfarag/screens/add_movie_screen.dart';
import 'package:etfarag/screens/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../providers/live_channel_provider.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                icon: Icon(Icons.add_box_sharp)),
            GestureDetector(
              onTap: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(300, 20, 30, 100),
                    items: [
                      PopupMenuItem(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user!.displayName!),
                          Text(user.email!),
                          SizedBox(
                            height: 15,
                          ),
                          IconButton(
                              icon: FaIcon(
                                  FontAwesomeIcons.arrowRightFromBracket),
                              onPressed: () {
                                context.read<GoogleSignInProvider>().logout();
                                Navigator.pop(context);
                              }),
                        ],
                      )),
                    ]);
              },
              child: CircleAvatar(
                backgroundImage: user != null
                    ? NetworkImage(user.photoURL!)
                    : NetworkImage(
                        'https://www.pngitem.com/pimgs/m/576-5768680_avatar-png-icon-person-icon-png-free-transparent.png'),
              ),
            )
          ],
          title: Text(
            'Etfarag',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
        body: Column(
          children: [
            Flexible(
                flex: 40,
                child: Column(
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
                                      scrollDirection: Axis.horizontal,
                                      itemCount: lcp.liveChannels.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return VideoPlayer(
                                                    url: lcp.liveChannels[index]
                                                        .url!);
                                              }));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        lcp.liveChannels[index]
                                                            .title!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1,
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
                                                    return VideoPlayer(
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
