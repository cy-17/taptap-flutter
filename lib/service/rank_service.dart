import 'package:TapTap/config/http/http.dart';
import 'package:TapTap/config/http_options.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:dio/dio.dart';

import 'game_service.dart';

class RankService {
  static Future<List<Game>> getRank(int page) async {
    List<Game> gameList = [];
    try {
      Response response = await Dio()
          .get("${HttpOptions.BASE_URL2}/game/mainlist/:classification/$page");
      List<dynamic> data = response.data['data']['GameMainList'];
      data.forEach((element) {
        Game game = Game(
            element['GameMainInfo']['GameName'],
            element['GameMainInfo']['Icon'],
            element['GameMainInfo']['Tags'].toString(),
            element['Score'],
            "");
        game.gameId = element['GameMainInfo']['GameId'];
        gameList.add(game);
      });
    } catch (e) {
      print(e);
    }
    return gameList;
  }

  static Future<List<Game>> getRankListI(int page) async {
    List<Game> gameList = [];
    try {
      Map<String, dynamic> response = await Http.get(
        "${GameService.BASEURL}/gameMainList/$page",
      );

      List<dynamic> data = await response['data']['gameMainList'];

      data.forEach((element) {
        String str = element['gameTags'].toString();
        str = str
            .substring(1, str.length - 1)
            .replaceAll(",", " ")
            .replaceAll("\"", "");
        Game game = Game(element['gameName'], element['gameIcon'], str,
            element['gameGrade'].toInt(), "");
        game.gameId = element['gameId'];
        game.gameApkUrl = element['gameApkUrl'];
        gameList.add(game);
      });
    } catch (e) {
      print(e);
    }
    return gameList;
  }
}
