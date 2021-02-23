import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/complain.dart';
import 'package:t_society/src/model/complain.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/complain.dart';
import 'package:t_society/src/model/response/pagination.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class ComplainListController extends GetxController {
  //dependency
  ComplainRepository complainRepository = sl.get();
  AppPreference appPreference = sl.get();

  //context
  BuildContext context;

  ComplainListController(this.context);

  //dialog variable
  var formKey = GlobalKey<FormState>();

  var complainListResponseObs = ApiResult.init().obs;
  var strStatusList = ["-Status-", "Resolved", "Failure", "Pending"];

  var filterStatusObs = ComplainFilterStatus.ALL.obs;
  var filterInputObs = ComplainFilterInput.BY_COMPLAIN_NAME.obs;



  Pagination pagination;
  int paginationPageKey = 1;
  final PagingController<int, Complain> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((firstPageKey) => fetchComplains());
    super.onInit();
  }

  var query;
  fetchComplains() async {
    try {
      ComplainListResponse result =
          await complainRepository.complains(paginationPageKey,query: query,status: complainStatus);
      query = null;
      List<Complain> mList = result.complains;
      int mLength = mList.length;

      final isLastPage = mLength < 20;
      if (isLastPage) {
        pagingController.appendLastPage(mList);
      } else {
        paginationPageKey += 1;
        pagingController.appendPage(mList, paginationPageKey);
      }
    } catch (e) {
      pagingController.error = e;
      //Get.to(ErrorScreen(e));
    }
  }

  updateComplainStatus(String complainId, int complainStatusId) async {
    AppDialog.squareTransparentProgress(context, title: "Updating...");

    try {
      CommonResponse result =
          await complainRepository.updateComplain(complainId, complainStatusId);
      Get.back();
      if (result.status == 1) {
        LottieDialog.resStatus(context, result.message,
            lottieType: LottieType.SUCCESS);
        paginationPageKey = 1;
        fetchComplains();
      } else
        LottieDialog.resStatus(context, result.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Get.back();
      Get.to(ErrorScreen(e));
    }
  }

  getStatusStrFromId(int id) => (id == 1)
      ? "Resolved"
      : (id == 2)
          ? "Failure"
          : (id == 3)
              ? "Pending"
              : null;

  getStatusIdFromStr(String str) => (str == "Resolved")
      ? 1
      : (str == "Failure")
          ? 2
          : (str == "Pending")
              ? 3
              : null;

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  var complainStatus = 0;
  void onComplainStatusChange(ComplainFilterStatus value) {

    Utils.printLog(value);

    paginationPageKey = 1;
    if(value == ComplainFilterStatus.SUCCESS)
      complainStatus = 1;
    else if(value == ComplainFilterStatus.FAILED)
      complainStatus = 2;
    else if(value == ComplainFilterStatus.PENDING)
      complainStatus = 3;
    else complainStatus = 0;
    pagingController.refresh();


  }
}


enum ComplainFilterStatus { ALL,SUCCESS,PENDING,FAILED }
enum ComplainFilterInput { BY_COMPLAIN_NAME,USERNAME,FLAT_NO,MOBILE, EMAIL }