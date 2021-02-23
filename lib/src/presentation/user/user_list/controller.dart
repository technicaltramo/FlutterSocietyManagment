import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/user.dart';
import 'package:t_society/src/model/response/pagination.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class UserListController extends GetxController {
  BuildContext context;

  UserListController(this.context);

  UserRepository userRepository = sl.get();

  User loggedInUser = sl.get<AppPreference>().user;

  var userListObs = ApiResult.init().obs;

  var searchFilterValue = FilterRadioValue.NAME.obs;



  Pagination pagination;
  int paginationPageKey = 1;
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);

  @override
  void onInit() {
    initPagination();
    super.onInit();
  }

  initPagination() {
    pagingController.addPageRequestListener((firstPageKey) => fetchUserList());
  }

  var query;
  fetchUserList() async {
    try {
      UserListResponse result = await userRepository.userList(paginationPageKey, query: query);
      query = null;
      List<User> mList = result.users;
      pagination = result.pagination;
      int mLength = mList.length;

      final isLastPage = mLength < 20;
      if (isLastPage) {
        pagingController.appendLastPage(mList);
      } else {
        paginationPageKey = pagination.next.page;
        pagingController.appendPage(mList, paginationPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  @override
  void onClose() {
    super.onClose();
    userListObs.close();
    pagingController.dispose();
  }
}

enum FilterRadioValue { NAME, MOBILE, FLAT, EMAIL }