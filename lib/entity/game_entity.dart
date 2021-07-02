class Game {
  int? gameId;
  String? gameName;
  String? gamePictureUrl;
  String? category;
  int? score;
  String? description;
  String? author;
  String? releaseDate;
  String? Introduction;
  String? Icon;
  List<dynamic>? detailImages;
  List<dynamic>? categorys;
  Map<String, dynamic>? GameCommentScore;
  String? gameApkUrl;
  Game(this.gameName, this.gamePictureUrl, this.category, this.score,
      this.description);
  Game.empty();
}
