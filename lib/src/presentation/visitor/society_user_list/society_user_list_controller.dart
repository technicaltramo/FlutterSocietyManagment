import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/user.dart';
import 'package:t_society/src/data/repository_impl/user.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/visitor/new_entry/screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class SocietyUserListController extends GetxController{
  var towerList = ["A","B"];
  var floorList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"];

  var appPreference = sl.get<AppPreference>();
  var userRepository = sl.get<UserRepository>();
  var userListResultObs = ApiResult<UserListResponse>.init().obs;
  List<User> userList;


  @override
  void onInit() {
    fetchUserList();
    super.onInit();
  }



  //todo (user pagination)
  fetchUserList() async{
   var adminId=  appPreference.user.createdBy;
   var result = await userRepository.userList(1,adminId: adminId);
   userListResultObs.value = ApiResult.fetched(data: result);
   Utils.printLog(result);
  }

  onNewVisitor(User user) async{
    Get.to(VisitorEntryScreen(user));
  }
}