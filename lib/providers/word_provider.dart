import 'package:dictionary/models/word_model.dart';
import 'package:dictionary/services/search_service.dart';
import 'package:flutter/cupertino.dart';

class WordProvider with ChangeNotifier {
  final searchService = SearchServices();
  WordModel? wordModel;
  bool loadingSearchWord = true;

  Future getSearchWordDataFromApi() async {
    dynamic wordData = await searchService.getWordDataFromApi();

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
}
