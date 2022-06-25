import 'package:etfarag/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);
  static const String id = 'add_movie_screen';
  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  MovieChannel? movieChannel = MovieChannel(
      id: null,
      title: '',
      description: '',
      url: '',
      image: '',
      isFavorite: false);
  final _formKey = GlobalKey<FormState>();

  Future _save() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      await context
          .read<MovieChannelsProvider>()
          .addMovie(movieChannel!)
          .whenComplete(() => Navigator.pop(context));
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (v) {
                    movieChannel = MovieChannel(
                        id: movieChannel!.id,
                        title: v,
                        description: movieChannel!.description,
                        image: movieChannel!.image,
                        url: movieChannel!.url,
                        isFavorite: false);
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Channel Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Channel Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  onSaved: (v) {
                    movieChannel = MovieChannel(
                        id: movieChannel!.id,
                        title: movieChannel!.title,
                        description: v,
                        image: movieChannel!.image,
                        url: movieChannel!.url,
                        isFavorite: false);
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Channel Description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  onSaved: (v) {
                    movieChannel = MovieChannel(
                        id: movieChannel!.id,
                        title: movieChannel!.title,
                        description: movieChannel!.description,
                        image: v,
                        url: movieChannel!.url,
                        isFavorite: false);
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Channel Image Url';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Image Url',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  onSaved: (v) {
                    movieChannel = MovieChannel(
                        id: movieChannel!.id,
                        title: movieChannel!.title,
                        description: movieChannel!.description,
                        image: movieChannel!.image,
                        url: v,
                        isFavorite: false);
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Channel Url';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Channel Url',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 250,
                ),
                ElevatedButton.icon(
                    onPressed: _save,
                    icon: Icon(Icons.radio),
                    label: Text('Add Channel'))
              ],
            )),
      )),
    );
  }
}
