import 'package:TapTap/config/http_options.dart';
import 'package:TapTap/entity/comment_entity.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:dio/dio.dart';

class CommentService {
  static String BASEURL = "/taptap/game-comment-info";

  static Future<List<Comment>> getOneComment(int gameId, int page) async {
    List<Comment> gameCommentList = [];
    try {
      Response response = await Dio().get(
          "${HttpOptions.BASE_URL2}/game/comment",
          queryParameters: {"userid": "12", "gameid": gameId, "offset": page});
      if (response.data['code'] == 200) {
        List<dynamic> commentList = response.data['data']['GameCommentRep'];
        commentList.forEach((comment) {
          Comment gameComment = Comment();
          gameComment.commentId = comment['GameParentComment']['CommentId'];
          gameComment.gameId = gameId;
          gameComment.commentUserId = comment['GameParentComment']['UserId'];
          gameComment.commentDetail =
              comment['GameParentComment']['Content'] ?? "获取评论详情失败";
          gameComment.commentTime = comment['GameParentComment']['CreateAt'];
          gameComment.commentScore = comment['GameParentComment']['Score'];
          gameComment.userNickName = comment['GameParentComment']['Nickname'];
          gameComment.userNickName = comment['GameParentComment']['Nickname'];
          gameComment.userCoverUrl = comment['GameParentComment']['Avatar'];
          gameCommentList.add(gameComment);
        });
      }
    } catch (e) {
      print(e);
    }
    return gameCommentList;
  }

  static Future<List<Comment>> getChildComment(int commentId, int page) async {
    List<Comment> gameCommentList = [];
    try {
      Response response = await Dio().get(
          "${HttpOptions.BASE_URL2}/game/childcomment",
          queryParameters: {"commentid": commentId, "offset": page});
      if (response.data['code'] == 200) {
        List<dynamic> commentList = response.data['data']['GameCommentList'];
        commentList.forEach((comment) {
          Comment gameComment = Comment();
          gameComment.commentId = comment['CommentId'];
          gameComment.commentUserId = comment['UserId'];
          gameComment.commentDetail = comment['Content'] ?? "获取评论详情失败";
          gameComment.commentTime = comment['CreateAt'];
          gameComment.userNickName = comment['UserNickname'];
          gameComment.commentReplyToNickName = comment['RepliedNickname'];
          gameComment.userCoverUrl = comment['Avatar'];
          gameCommentList.add(gameComment);
        });
      }
    } catch (e) {
      print(e);
    }
    return gameCommentList;
  }

  static Future<bool> writeComment(
      String content, int score, int gameid) async {
    try {
      Response response =
          await Dio().post("${HttpOptions.BASE_URL2}/game/comment", data: {
        "gameid": gameid,
        "userid": GlobalData.userInfo!.userId,
        "content": content,
        "score": score
      });
      if (response.data['code'] == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> writeSubComment(
      int gameId, int commenetParId, commentToId, String content) async {
    try {
      Response response =
          await Dio().post("${HttpOptions.BASE_URL2}/game/comment", data: {
        "userid": GlobalData.userInfo!.userId,
        "content": content,
        "gameid": gameId,
        "repliedid": commentToId,
        "pid": commenetParId
      });
      if (response.data['code'] == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<List<Comment>> getCommentByUserId(int userId, int page) async {
    List<Comment> commentListR = [];
    try {
      Response response = await Dio().get(
        "${HttpOptions.BASE_URL2}/game/usercomment/$userId/$page",
      );
      List<dynamic> data = response.data['data'];

      data.forEach((element) {
        Comment comment = Comment();
        comment.commentDetail = element['GameParentComment']['Content'];
        comment.commentScore = element['GameParentComment']['Score'];
        comment.commentTime = element['GameParentComment']['CreateAt'];
        comment.commentThumpupCount = element['LikeCount'];
        comment.commentGameName = element['GameParentComment']['GameName'];
        comment.commentGameCoverUrl = element['GameParentComment']['Icon'];
        comment.commentId = element['GameParentComment']['CommentId'];
        comment.gameId = element['GameParentComment']['GameId'];
        commentListR.add(comment);
      });
    } catch (e) {
      print(e);
    }
    return commentListR;
  }

  static Future<List<Comment>> getCommentByUserIdAndGameId(
      int userId, int gameId, int page) async {
    List<Comment> commentListR = [];
    try {
      Response response = await Dio().get(
        "${HttpOptions.BASE_URL2}/game/usercomment/$userId/$page",
      );
      List<dynamic> data = response.data['data'];
      data.forEach((element) {
        if (element['GameParentComment']['GameId'] != null &&
            element['GameParentComment']['GameId'] == gameId) {
          Comment comment = Comment();
          comment.commentDetail =
              element['GameParentComment']['Content'] ?? "获取评论详情失败";
          comment.commentScore = element['GameParentComment']['Score'];
          comment.commentTime = element['GameParentComment']['CreateAt'];
          comment.commentThumpupCount = element['LikeCount'];
          comment.commentId = element['GameParentComment']['CommentId'];
          comment.gameId = gameId;
          comment.userNickName = GlobalData.userInfo!.userNickName;
          comment.commentUserId = element['GameParentComment']['UserId'];
          comment.userCoverUrl = GlobalData.userInfo!.userCoverUrl;
          commentListR.add(comment);
        }
      });
    } catch (e) {
      print(e);
    }
    return commentListR;
  }

  static Future<bool> deleteComment(
      int userId, int gameId, int commentId) async {
    Response response = await Dio().delete(
        "${HttpOptions.BASE_URL2}/game/comment",
        data: {"userid": userId, "gameid": gameId, "commentid": commentId});
    print(response.data.toString());
    return false;
  }
}
