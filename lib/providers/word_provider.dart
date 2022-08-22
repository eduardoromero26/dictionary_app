import 'package:dictionary/models/word_model.dart';
import 'package:dictionary/services/search_service.dart';
import 'package:flutter/cupertino.dart';

class WordProvider with ChangeNotifier {
  final searchService = SearchServices();
  WordModel? wordModel;
  bool loadingSearchWord = true;
  List<String> likedList = [];

  Future getSearchWordDataFromApi(word) async {
    dynamic wordData = await searchService.getWordDataFromApi(word);

    if (wordData != null) {
      wordModel = WordModel(
        id: wordData['id'],
        phoneticSpelling: wordData['lexicalEntries'][0]['entries'][0]
            ['pronunciations'][0]['phoneticSpelling'],
        audioFile: wordData['lexicalEntries'][0]['entries'][0]['pronunciations']
            [1]['audioFile'],
        definitions: wordData['lexicalEntries'][0]['entries'][0]['senses'][0]
            ['definitions'][0],
      );
    }
    loadingSearchWord = false;
    notifyListeners();
  }

  getIfWordLiked(word) {
    return likedList.contains(word);
  }

  addNewWord(newWord) {
    likedList.add(newWord);
    notifyListeners();
  }

  deleteWordFromLiked(likedWord) {
    likedList.remove(likedWord);
    notifyListeners();
  }
}
