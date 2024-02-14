import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class WareHouseSetupController extends GetxController {
  WareHouseSetupController({required this.context});
  final BuildContext context;
  late data_api2 api;
  var user = ModelUser().obs;
  late CustomAwesomeDialog dialog;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  var cmb_StoteTypeID = ''.obs;
  var cmb_SatusID = ''.obs;
  var editWarehouseID = ''.obs;
  var isCentralStore = false.obs;
  final TextEditingController txt_warehouse_name = TextEditingController();

  var storeTypeList = <ModelCommonMaster>[].obs;
  var statusList = <ModelStatusMaster>[].obs;

  @override
  void onInit() async {
    super.onInit();
    dialog = CustomAwesomeDialog(context: context);
    api = data_api2();
    isLoading.value = true;
    isError.value = false;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      // ignore: unnecessary_null_comparison
      if (user.value == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }

      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //print(x);
      storeTypeList
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      // storeTypeList.insert(
      //     0, ModelCommonMaster(id: "0", name: "All Type", status: "1"));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value.toString();
    }
  }
}
