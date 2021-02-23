import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';
import 'package:volume/volume.dart';

class UpcomingVisitorController extends GetxController{
 // final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  AudioManager audioManager;
  AppPreference appPreference = sl.get<AppPreference>();
  @override
  void onInit() {
    audioManager = AudioManager.STREAM_MUSIC;
    appPreference.visitorInfo = null;
    playTone();
    super.onInit();
  }

  playTone() async{
    Volume.controlVolume(audioManager);
    int maxVolume = await Volume.getMaxVol;
    int currentVolume = await Volume.getVol;
    Utils.printLog(maxVolume);
    Utils.printLog(currentVolume);
    await Volume.setVol(maxVolume,showVolumeUI: ShowVolumeUI.HIDE);
   /* _assetsAudioPlayer.open(Audio("assets/audio/visitor_tone.mp3"),
      showNotification: true,
      loopMode: LoopMode.single,);*/
  }

  @override
  void onClose() {
    //_assetsAudioPlayer.stop();
    //_assetsAudioPlayer.dispose();
    super.onClose();
  }
}