// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_department.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';

class LabDiagnosticGroupSetupController extends GetxController {
  LabDiagnosticGroupSetupController({required this.context});
  final BuildContext context;
  late data_api2 api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatusMaster>[].obs;
  var editGroupID = ''.obs;
  var cmb_groupStatusID = ''.obs;
  var cmb_departmentID = ''.obs;
  final TextEditingController txt_group_name = TextEditingController();
  final TextEditingController txt_group_search = TextEditingController();

  var department_list_all = <ModelDepartment>[].obs;
  var department_list_temp = <ModelDepartment>[].obs;

  void saveUpdateGroupSetup(BuildContext context) async {
    dialog = CustomAwesomeDialog(context: context);
   // print("ok");
    if (txt_group_name.text == '') {
       dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid group name!"
        ..show();
      return;
    }
    if (cmb_departmentID.value == '') {
      customAwesamDialodOk(context, DialogType.error, "Warning!",
          "Please Select Department", () {});
      return;
    }
    if (cmb_groupStatusID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select status!"
        ..show();
      return;
    }

    try {
       loader = CustomBusyLoader(context: context);
      loader.show();
//@cid ,@did,  @id ,@name ),@status

      api
          .createLead([
            {
              "tag": "45",
              "cid": user.value.cid,
              "did": cmb_departmentID.value,
              "id": editGroupID.value == '' ? "0" : editGroupID.value,
              "name": txt_group_name.text,
              "status": cmb_groupStatusID.value
            }
          ])
          .then((value) => getStatusWithDialog(value, dialog))
          .then((value) {
            if (value.status == "1") {
              txt_group_name.text = '';
              cmb_groupStatusID.value = '1';
            }
          });

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void dispose() {
    // Use the saved reference to the ancestor widget
    // This ensures that the ancestor widget is still accessible during dispose

    super.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    api = data_api2();
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();

      if (user.value == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }

      var x = await api.createLead([
        {"tag": "23", "cid": user.value.cid}
      ]);
      department_list_all
          .addAll(x.map((e) => ModelDepartment.fromJson(e)).toList());
      department_list_temp.addAll(department_list_all);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }
}
