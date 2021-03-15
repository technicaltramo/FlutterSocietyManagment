import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/visitor.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';
import 'package:volume/volume.dart';

class UpcomingVisitorController extends GetxController {
  BuildContext context;
  VisitorRepository repository = sl.get();
  Visitor visitor;

  UpcomingVisitorController(this.context, this.visitor);

  //UI
  TextStyle h6TStyle;
  TextStyle h6TStyle2;
  double topBarSize = 0.0;

  // final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  AudioManager audioManager;
  AppPreference appPreference = sl.get<AppPreference>();

  @override
  void onInit() {
    _initUIStuff();
    audioManager = AudioManager.STREAM_MUSIC;
    appPreference.visitor = null;
    playTone();
    super.onInit();
  }

  _initUIStuff() {
    h6TStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.black87, fontSize: 28);
    h6TStyle2 = Theme.of(context).textTheme.headline4.copyWith(fontSize: 22);
    topBarSize = MediaQuery.of(context).padding.top;
  }

  playTone() async {
    Volume.controlVolume(audioManager);
    int maxVolume = await Volume.getMaxVol;
    int currentVolume = await Volume.getVol;
    Utils.printLog(maxVolume);
    Utils.printLog(currentVolume);
    await Volume.setVol(maxVolume, showVolumeUI: ShowVolumeUI.HIDE);
    /* _assetsAudioPlayer.open(Audio("assets/audio/visitor_tone.mp3"),
      showNotification: true,
      loopMode: LoopMode.single,);*/
  }

  void onAcceptRejectVisitor(bool isAccept) async {
    CommonResponse response = await repository.onVisitorAcceptReject(isAccept,
        visitor.userId, visitor.guardId, visitor.visitorId);

    Utils.printLog(response.toString());
  }

  @override
  void onClose() {
    //_assetsAudioPlayer.stop();
    //_assetsAudioPlayer.dispose();
    super.onClose();
  }
}
