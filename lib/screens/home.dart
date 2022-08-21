import 'package:dictionary/screens/search_screen.dart';
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 480,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/face_bg.png"),
                        fit: BoxFit.none,
                      ),
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
                            hintStyle: TextStyle(color: ColorsTheme.darkPurple),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                          word: _searchWordCtrl.text)),
                                );
                              },
                              child: const Text('Search')))
                    ],
                  ),
                )
              ],
            ),
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
