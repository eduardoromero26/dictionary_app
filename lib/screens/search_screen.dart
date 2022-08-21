import 'package:dictionary/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/word_provider.dart';
import 'package:just_audio/just_audio.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.word}) : super(key: key);

  final String word;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late AudioPlayer player;

  @override
  void initState() {
    context.read<WordProvider>().getSearchWordDataFromApi(widget.word);
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<WordProvider>().wordModel?.id != widget.word
          ? const Center(child: CircularProgressIndicator.adaptive())
          : _buildContent(),
    );
  }

  @override
  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   Icon(Icons.star_border_outlined),
          // ],
          ),
      backgroundColor: ColorsTheme.bgGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.watch<WordProvider>().wordModel?.id}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${context.watch<WordProvider>().wordModel?.phoneticSpelling}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      IconButton(
                          onPressed: () async {
                            await player.setUrl(
                                'https://audio.oxforddictionaries.com/en/mp3/song_1_us_1.mp3');
                            await player.play();
                          },
                          icon: Icon(Icons.play_arrow)),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          '${context.watch<WordProvider>().wordModel?.definitions}')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsTheme.white,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(color: ColorsTheme.darkPurple),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.deepPurple,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }
}
