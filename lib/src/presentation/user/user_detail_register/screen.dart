import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/color.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/state_district.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/user/user_detail_register/controller.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class UserRegisterScreen extends GetView<UserRegisterController> {
  final User user;

  UserRegisterScreen(this.user);

  @override
  Widget build(BuildContext context) {
    Get.put(UserRegisterController(user, context));
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appBackground,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Obx(() {
            bool isLoading = controller.isLoadingObs.value;
            return _buildHome(isLoading);
          }),
        ),
      ),
    );
  }

  _buildHome(bool isLoading) {
    return Container(
      child: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //APP BAR
                  _appBarTitle(),

                  //USER INFO
                  _buildUserInfoWidget(),

                  //SOCIETY USER LIST
                  Obx(() {
                    bool isSocietyUserListMode =
                        controller.isSocietyUserListMode.value;
                    return (isSocietyUserListMode)
                        ? _buildUserList()
                        : Nothing();
                  }),

                  //FORM
                  Obx(() {
                    bool isEditMode = controller.isEditMode.value;
                    return (isEditMode || controller.user == null)
                        ? _buildUserRegisterForm()
                        : SizedBox.shrink();
                  })
                ],
              ),
            ),
    );
  }

  _buildUserList() {
    ApiResult result = controller.societyAdminUserListObs.value;
    return result.when(fetched: (data) {
      UserListResponse response = data;
      List<User> userList = response.users;
      return (userList.length > 0)
          ?
      Column(
        children: <Widget>[
          ...userList.map((item) {
            return _buildListCard(item);
          }).toList(),
        ],
      )

      /*ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return _buildListCard(userList[index]);
              })*/
          : Center(
              child: Text("No user found"),
            );
    }, init: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  _buildListCard(User user, {bool isLastItem = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.cyan,
                  child: Icon(Icons.person),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "${user.name}",
                            style: AppTextStyle.cardH2(),
                          ),
                          Text(
                            "   -   ${user.flatNo}",
                            style: AppTextStyle.text2(),
                          ),
                        ],
                      ),
                      AppWidget.height(value: 4),
                      Text(
                        "${user.mobile}",
                        style: AppTextStyle.text2(),
                      ),
                      Text(
                        "${user.email}",
                        style: AppTextStyle.text2(),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Get.to(UserRegisterScreen(user));
                      },
                      icon: Icon(
                        Icons.info,
                        size: 40,
                        color: Colors.blue[300],
                      ),
                    ),
                    (user.active)
                        ? Text(
                            "Active",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            "Inactive",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          )
                  ],
                )
              ],
            ),
          ),
          BuildHorizontalLine()
        ],
      ),
    );
  }

  Widget _buildUserInfoWidget() {
    return (controller.user != null)
        ? Card(
            margin: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        _mWidget(
                            "Role",
                            (controller.user.role == "app_admin")
                                ? "App Admin"
                                : (controller.user.role == "society_admin")
                                    ? "Society Admin"
                                    : "Member"),
                        _mWidget("Name", controller.user.name),
                        _mWidget("Mobile", controller.user.mobile.toString()),
                        _mWidget("Email", controller.user.email),
                        _mWidget("Flat No", controller.user.flatNo),
                        _mWidget("Aadhaar No.",
                            controller.user.aadhaarNumber.toString()),
                        _mWidget("Status",
                            (controller.user.active) ? "Active" : "No Active"),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Obx(() {
                        bool isEditMode = controller.isEditMode.value;

                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            controller.isSocietyUserListMode.value = false;
                            controller.isEditMode.value = !isEditMode;
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              (isEditMode) ? Icons.cancel : Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 16,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      (controller.appPreference.user.role == "app_admin")
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                controller.uploadUserExcelData(user.mobile.toString());
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Nothing(),
                      SizedBox(
                        height: 16,
                      ),
                      (controller.appPreference.user.role == "app_admin")
                          ? Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "50",
                                    style: AppTextStyle.cardH2(),
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: controller.onViewUserListButtonClicked,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Obx(() {
                                      return Icon(
                                        (controller.isSocietyUserListMode.value)
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      );
                                    }),
                                  ),
                                )
                              ],
                            )
                          : Nothing()
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  _appBarTitle() {
    AppPreference appPreference = controller.appPreference;
    bool isEditMode = controller.isEditMode.value;
    var title = (appPreference.user.role == "app_admin")
        ? "Create New Society & Their Admin"
        : "Create New Society User";
    if (controller.user != null)
      title = (isEditMode) ? "Edit User" : "User Info";
    return AppTitleText1(title: title,);

  }

  _buildUserRegisterForm() {
    var inputNode = FocusScope.of(controller.context);
    AppPreference appPreference = controller.appPreference;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: controller.registerKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (appPreference.user.role == "app_admin")
                ? Card(
                    child: Column(
                      children: <Widget>[
                      //  AppText.mediumTitle("Society Info"),
                        AppTitleText1(title: "Society Info",),
                        AppTextFormField(
                            onEditingComplete: () => inputNode.nextFocus(),
                            controller: controller.societyNameController,
                            labelText: "Society Name",
                            validator: (String value) {
                              return (value.length < 4)
                                  ? "can't be less than 4 character"
                                  : null;
                            }),
                        Checkbox(
                          value: controller.isTower.value,
                          onChanged: (value) {
                            controller.isTower.value = value;
                          },
                        ),
                        _buildStateDropDown(),
                        _buildDistrictDropDown(),
                        AppTextFormField(
                            onEditingComplete: () => inputNode.nextFocus(),
                            controller: controller.addressLine1Controller,
                            labelText: "Address Line 1",
                            validator: (String value) {
                              return (value.length < 4)
                                  ? "can't be less than 4 character"
                                  : null;
                            }),
                        AppTextFormField(
                            onEditingComplete: () => inputNode.nextFocus(),
                            controller: controller.addressLine2Controller,
                            labelText: "Address Line 2",
                            validator: (String value) {
                              return (value.length < 4)
                                  ? "can't be less than 4 character"
                                  : null;
                            }),
                        AppTextFormField(
                            onEditingComplete: () => inputNode.nextFocus(),
                            controller: controller.pinCodeController,
                            labelText: "PinCode",
                            validator: (String value) {
                              return (value.length != 6)
                                  ? "can't be less than 6 digits"
                                  : null;
                            }),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Card(
              child: Column(
                children: <Widget>[
                 // AppText.mediumTitle("User Info"),
                  AppTitleText2(title: "User Info",),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.adminNameController,
                      labelText: "User Name",
                      validator: (String value) {
                        return (value.length < 4)
                            ? "can't be less than 4 character"
                            : null;
                      }),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.mobileController,
                      labelText: "Mobile",
                      fieldType: TextFieldType.MOBILE,
                      validator: (String value) {
                        return (value.length != 10)
                            ? "can't be less than 10 digits"
                            : null;
                      }),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.emailController,
                      labelText: "Email",
                      fieldType: TextFieldType.EMAIL,
                      validator: (String value) {
                        return (value.length < 4)
                            ? "can't be less than 4 character"
                            : null;
                      }),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.aadharNumberController,
                      labelText: "Aadhaar Number",
                      fieldType: TextFieldType.NUMBER,
                      validator: (String value) {
                        return (value.length != 12)
                            ? "can't be less than 12 digits"
                            : null;
                      }),
                  AppTextFormField(
                      controller: controller.flatNoController,
                      onEditingComplete: () => inputNode.unfocus(),
                      labelText: "Flat No",
                      validator: (String value) {
                        return (value.isEmpty) ? "can't be empty" : null;
                      }),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
            AppWidget.height(value: 20),
            AppButton(
                buttonText: (controller.user == null) ? "Register" : "Update",
                padding: EdgeInsets.symmetric(horizontal: 12),
                onPress: () {
                  (controller.user == null)
                      ? controller.onRegisterButtonClicked()
                      : controller.onUpdateButtonClicked();
                }),
          ],
        ),
      ),
    );
  }

  Obx _buildStateDropDown() {
    return Obx(() {
      List<CountryState> stateList = controller.stateListObs;
      List<String> ddList = stateList.map((e) => e.name).toList();
      ddList.insert(0, "Select State");
      return AppDropDown(
          dropdownList: ddList,
          selectedValue: controller.selectedState?.name,
          validator: (String value) =>
              (value == "Select State") ? "Select State" : null,
          onValueChanged: (String value) {
            if (value != "Select State") {
              CountryState states = CountryState.getStateByName(stateList, value);
              controller.selectedState = states;
              if (states != null) {
                controller.selectedDistrict = null;
                controller.fetDistrictFromStateId(states.id);
              }
            }
          });
    });
  }

  Obx _buildDistrictDropDown() {
    return Obx(() {
      List<District> districtList = controller.districtListObs;
      List<String> ddList = districtList.map((e) => e.name).toList();
      ddList.insert(0, "Select District");
      return AppDropDown(
          dropdownList: ddList,
          selectedValue: controller.selectedDistrict?.name,
          validator: (String value) =>
              (value == "Select District") ? "Select District" : null,
          onValueChanged: (String value) {
            District districts =
                District.getDistrictByName(districtList, value);
            controller.selectedDistrict = districts;
          });
    });
  }

  _mWidget(String title, String vale) {
    Color statusColor = Colors.green;
    if (title == "Status") if (vale == "Inactive") statusColor = Colors.red;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
          Text(
            "  :  ",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Expanded(
              flex: 2,
              child: Text(
                vale,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: (title == "Status") ? statusColor : Colors.black54),
              )),
        ],
      ),
    );
  }
}
