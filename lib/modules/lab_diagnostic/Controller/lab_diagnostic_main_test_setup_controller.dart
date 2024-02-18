// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_department.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';
import 'package:web_2/modules/lab_diagnostic/Model/model_test_group_master.dart';
import 'package:web_2/modules/lab_diagnostic/Model/model_test_main.dart';

class LabDiagnosticMainTestSetupController extends GetxController {
  late BuildContext context;
  late data_api2 api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatusMaster>[].obs;
  var editTestID = ''.obs;
  var cmb_departmentID = ''.obs;
  var cmb_groupID = ''.obs;
  var cmb_headID = ''.obs;
  var cmb_statusID = ''.obs;
  final TextEditingController txt_test_name = TextEditingController();
  final TextEditingController txt_tsearch = TextEditingController();

  var department_list_all = <ModelDepartment>[].obs;

  var group_list_all = <ModelTestGroupMaster>[].obs;
  var group_list_temp = <ModelTestGroupMaster>[].obs;

  var service_head_List = <ModelCommonMaster>[].obs;

  var testmain_list_all = <ModelTestMainSetup>[].obs;
  var testmain_list_temp = <ModelTestMainSetup>[].obs;

  void LoadGroupList() async {
    group_list_temp.clear();
    group_list_temp.addAll(
        group_list_all.where((p0) => p0.deptId == cmb_departmentID.value));
  }

  void saveUpdateMainTest() async {
    dialog = CustomAwesomeDialog(context: context);
    // print("ok");
    if (txt_test_name.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid main test name!"
        ..show();
      return;
    }
    if (cmb_departmentID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select department!"
        ..show();
      return;
    }
    if (cmb_groupID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select group!"
        ..show();
      return;
    }
    if (cmb_headID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select Head Name!"
        ..show();
      return;
    }
    if (cmb_statusID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select status!"
        ..show();
      return;
    }

    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      //@cid ,@did ,@grp_id ,@hid  ,  @id,@name,@status
      api
          .createLead([
            {
              "tag": "46",
              "cid": user.value.cid,
              "did": cmb_departmentID.value,
              "grp_id": cmb_groupID.value,
              "hid": cmb_headID.value,
              "id": editTestID.value == '' ? "0" : editTestID.value,
              "name": txt_test_name.text,
              "status": cmb_statusID.value
            }
          ])
          .then((value) => getStatusWithDialog(value, dialog))
          .then((value) {
            loader.close();
            if (value.status == "1") {
              if (editTestID.value != '') {
                testmain_list_all
                    .removeWhere((element) => element.id == editTestID.value);
              }

              testmain_list_all.insert(
                  0,
                  ModelTestMainSetup(
                      deptId: cmb_departmentID.value,
                      deptName: department_list_all
                          .where((p0) => p0.id == cmb_departmentID.value)
                          .first
                          .name,
                      grpId: cmb_groupID.value,
                      grpName: group_list_all
                          .where((p0) => p0.id == cmb_groupID.value)
                          .first
                          .name,
                      headName: service_head_List
                          .where((p0) => p0.id == cmb_headID.value)
                          .first
                          .name,
                      hid: cmb_headID.value,
                      id: value.id,
                      name: txt_test_name.text,
                      status: cmb_statusID.value));
              testmain_list_temp.clear();
              testmain_list_temp.addAll(testmain_list_all);
              editTestID.value = '';
              txt_test_name.text = '';

              // group_list_all.add(ModelTestGroupMaster(
              //     deptId: cmb_departmentID.value,
              //     deptName: department_list_all
              //         .where((p0) => p0.id == cmb_departmentID.value)
              //         .first
              //         .name,
              //     id: value.id,
              //     name: txt_group_name.text,
              //     status: cmb_groupStatusID.value));
              // group_list_temp.clear();
              // group_list_temp.addAll(group_list_all);

              // txt_group_name.text = '';
              // cmb_groupStatusID.value = '1';
              // editGroupID.value = '';
            }
          });

     
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
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

      x = await api.createLead([
        {"tag": "41", "cid": user.value.cid}
      ]);
      service_head_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "44", "cid": user.value.cid}
      ]);

      group_list_all
          .addAll(x.map((e) => ModelTestGroupMaster.fromJson(e)).toList());

      group_list_temp.clear();

      x = await api.createLead([
        {"tag": "47", "cid": user.value.cid}
      ]);

      testmain_list_all
          .addAll(x.map((e) => ModelTestMainSetup.fromJson(e)).toList());
      testmain_list_temp.addAll(testmain_list_all);

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }
}
