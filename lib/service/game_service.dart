import 'package:TapTap/config/http/http.dart';
import 'package:TapTap/config/http_options.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:dio/dio.dart';

class GameService {
  static const String BASEURL = "/taptap/game-info/";

  static Future<List<Game>> getRecommend(int page) async {
    List<Game> gameList = [];
    try {
      Response response =
          await Dio().get("${HttpOptions.BASE_URL2}/game/reclist/$page");
      List<dynamic> data = response.data['data']['GameRecListRep'];
      data.forEach((element) {
        Game game = Game(
            element['GameInfo']['GameName'],
            element['GameInfo']['CoverImage'],
            "",
            element['Score'],
            element['GameInfo']['ShortDesc']);
        game.gameId = element['GameInfo']['GameId'];
        gameList.add(game);
      });
    } catch (e) {
      print(e);
    }
    return gameList;
  }

  static Future<Game> getParticularGame(int gameId) async {
    Response response =
        await Dio().get("${HttpOptions.BASE_URL2}/game/gameprofile/$gameId");
    dynamic data = response.data['data']['Game'];
    Game game = Game.empty();
    game.gameId = gameId;
    game.gameName = data['GameName'];
    game.releaseDate = data['ReleaseAt'];
    game.author = data['Author'];
    game.description = data['Introduction'];
    game.gamePictureUrl = data['CoverImage'];
    game.category = data['Tags'].toString();
    game.categorys = data['Tags'];
    game.Icon = data['Icon'];
    game.GameCommentScore =
        response.data['data']['GameCommentScore']['GameCommentScore'];
    game.detailImages = data['DetailImages'];
    game.score = response.data['data']['GameCommentScore']['TotalScore'];
    return game;
  }

  static Future<List<Game>> getRecommendI(int page) async {
    List<Game> gameList = [];
    Map<String, dynamic> response = await Http.get(
      "${BASEURL}recommendList/$page",
    );
    List<dynamic> data = await response['data']['recommendList'];
    data.forEach((element) {
      Game game = Game(element['gameName'], element['gameCoverUrl'], "",
          element['gameGrade'].toInt(), element['gameRecommendDescription']);
      game.gameId = element['gameId'];
      gameList.add(game);
    });
    return gameList;
  }

  static Future<Game> getParticularGameI(int gameId) async {
    Map<String, dynamic> response = await Http.get("${BASEURL}detail/$gameId");
    dynamic data = response['data']['gameInfo'];
    Game game = Game.empty();
    game.gameId = gameId;
    game.gameName = data['gameName'];
    game.releaseDate = data['gameUpdateTime'] ?? "unknown";
    game.author = data['gameDeveloper'];
    game.description = data['gameDescription'];
    game.gamePictureUrl = data['gameCoverUrl'];
    game.category = data['gameTags'].toString();

    game.categorys = game.category!
        .substring(1, game.category!.length - 1)
        .replaceAll("\"", "")
        .split(",");
    game.Icon = data['gameIcon'];
    game.detailImages = data['gameFeaturesUrl']
        .substring(1, data['gameFeaturesUrl'].length - 1)
        .replaceAll("\"", "")
        .split(",");
    game.score = data['gameGrade'].toInt();
    return game;
  }
}
