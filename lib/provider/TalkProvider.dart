import 'package:flutter/material.dart';
import 'package:yanyou/models/Talk.dart';

class TalkProvider extends ChangeNotifier {
  List<TalkModel> talksModel;
  List<TalkModel> selfTalksModel;

  initTalkModel(String type, List json) {
    List<TalkModel> tempModels = json
        .map((item) {
          return TalkModel.fromJson(item);
        })
        .cast<TalkModel>()
        .toList();
    if (type == 'self') {
      selfTalksModel = tempModels;
    } else {
      print(tempModels.where((item) {
        return item.talkStatus == 0;
      }));
      talksModel = tempModels.where((item) {
        return item.talkStatus == 0;
      }).toList();
    }
    notifyListeners();
  }

  addTalkModel(String type, List json) {
    List<TalkModel> tempModels = json
        .map((item) {
          return TalkModel.fromJson(item);
        })
        .cast<TalkModel>()
        .toList();
    if (type == 'self') {
      selfTalksModel.addAll(tempModels);
    } else {
      talksModel.addAll(tempModels.where((item) {
        return item.talkStatus == 0;
      }).toList());
    }
    notifyListeners();
  }

  updateLike(String type, int talkId, Map<String, dynamic> json) {
    Like like = Like.fromJson(json);
    if (type == 'self') {
      selfTalksModel.forEach((talkModel) {
        if (talkModel.talkId == talkId) {
          talkModel.talkLike = like;
        }
      });
    } else {
      talksModel.forEach((talkModel) {
        if (talkModel.talkId == talkId) {
          talkModel.talkLike = like;
        }
      });
    }

    notifyListeners();
  }

  updateComment(String type, int talkId, int comment) {
    if (type == 'self') {
      selfTalksModel.forEach((talkModel) {
        if (talkModel.talkId == talkId) {
          talkModel.comment = comment;
        }
      });
    } else {
      talksModel.forEach((talkModel) {
        if (talkModel.talkId == talkId) {
          talkModel.comment = comment;
        }
      });
    }
    notifyListeners();
  }

  deleteTalk(int talkId) {
    int id;
    selfTalksModel.forEach((talkModel) {
      if (talkModel.talkId == talkId) {
        id = selfTalksModel.indexOf(talkModel);
      }
    });
    selfTalksModel.removeAt(id);
    notifyListeners();
  }
}
