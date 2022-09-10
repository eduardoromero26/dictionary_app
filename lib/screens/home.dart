import 'package:dictionary/screens/favorites.dart';
import 'package:dictionary/screens/search_screen.dart';
import 'package:dictionary/services/search_service.dart';
import 'package:dictionary/styles/colors.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController _searchWordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.bgGray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 480,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 20),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/face_bg.png"),
                            fit: BoxFit.none,
                            opacity: 0.1),
                        color: ColorsTheme.darkPurple,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Larousse',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Robt'),
                        ),
                        const Text(
                          'English en-us',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'roboto'),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: TextField(
                            controller: _searchWordCtrl,
                            decoration: const InputDecoration(
                              icon: IconButton(
                                  onPressed: null,
                                  icon: const Icon(
                                    Icons.search,
                                    color: ColorsTheme.darkPurple,
                                  )),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Search for a word...",
                              hintStyle:
                                  TextStyle(color: ColorsTheme.darkPurple),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                            height: 52,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: ElevatedButton(
                                onPressed: () async {
                                  var resp = await SearchServices()
                                      .getWordDataFromApi(_searchWordCtrl.text);
                                  if (resp.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              word: _searchWordCtrl.text)),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Try again"),
                                        content: Text(
                                            "We could not find: ${_searchWordCtrl.text}"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              color: Colors.deepPurpleAccent,
                                              padding: const EdgeInsets.all(14),
                                              child: const Text(
                                                "okay",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Search')))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsTheme.white,
        currentIndex: 0,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(color: ColorsTheme.darkPurple),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
              break;
            case 2:
              break;
            default:
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.deepPurple,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }
}
