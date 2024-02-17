import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/lab_diagnostic/Controller/lab_Diagnostic_Group_Setup_Controller.dart';

class LabDiagnosticGroupSetup extends StatelessWidget {
  const LabDiagnosticGroupSetup({super.key});
  void disposeController() {
    try {
      Get.delete<LabDiagnosticGroupSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
     
    
    LabDiagnosticGroupSetupController cnt =
        Get.put(LabDiagnosticGroupSetupController(context: context));
    return Scaffold(
      body: Obx(() => CustomCommonBody(cnt.isLoading.value, cnt.isError.value,
          cnt.errorMessage.value, _mobile(cnt,context), _mobile(cnt,context), _desktop(cnt,context))),
    );
  }
}

_mobile(LabDiagnosticGroupSetupController cnt,BuildContext context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [Expanded(child: _groupMaster(cnt,context))],
      ),
    );
_desktop(LabDiagnosticGroupSetupController cnt,BuildContext context) => Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _groupMaster(cnt,context),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          )
        ],
      ),
    );

_groupMaster(LabDiagnosticGroupSetupController cnt,BuildContext context) => CustomAccordionContainer(
        headerName: "Diagnostic Group Master",
        height: 0,
        isExpansion: false,
        children: [
          _groupEntry(cnt,context),
          height(),
          _groupTablePart(cnt),
        ]);

_groupTablePart(LabDiagnosticGroupSetupController cnt) => Expanded(
      child: Column(
        children: [
          height(),
          Row(
            children: [
              Expanded(
                  child: CustomSearchBox(
                      caption: "Group Search",
                      controller: cnt.txt_group_search,
                      onChange: (v) {}))
            ],
          ),
          height(),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(50),
                  1: FlexColumnWidth(120),
                  2: FlexColumnWidth(140),
                  3: FlexColumnWidth(80),
                  4: FlexColumnWidth(50),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      CustomTableCell("Group ID"),
                      CustomTableCell("Department"),
                      CustomTableCell("Group Gane"),
                      CustomTableCell("Status"),
                      CustomTableCell("Action"),
                    ],
                  ),
                  // for (var i = 0;
                  //     i < controller.service_urgency_List.length;
                  //     i++)
                  //   TableRow(
                  //       decoration: BoxDecoration(
                  //           color: controller.editServiceCatID.value ==
                  //                   controller.service_urgency_List[i].id
                  //               ? Colors.amber.withOpacity(0.3)
                  //               : Colors.white),
                  //       children: [
                  //         CustomTableCell(
                  //             controller.service_urgency_List[i].name!),
                  //         CustomTableCell(
                  //             controller.service_urgency_List[i].status == '1'
                  //                 ? "Active"
                  //                 : "Inactive"),
                  //         TableCell(
                  //             verticalAlignment:
                  //                 TableCellVerticalAlignment.middle,
                  //             child: InkWell(
                  //               onTap: () {
                  //                 controller.editServiceCatID.value =
                  //                     controller.service_urgency_List[i].id!;

                  //                 controller.txt_ServiceCatName.text =
                  //                     controller.service_urgency_List[i].name!;
                  //                 controller.cmb_service_cat_status.value =
                  //                     controller
                  //                         .service_urgency_List[i].status!;
                  //               },
                  //               child: const Padding(
                  //                 padding: EdgeInsets.all(4.0),
                  //                 child: Icon(
                  //                   Icons.edit,
                  //                   color: kWebHeaderColor,
                  //                   size: 12,
                  //                 ),
                  //               ),
                  //             )),
                  //       ])
                ],
                border: CustomTableBorder(),
              ),
            ),
          )
        ],
      ),
    );

_groupEntry(LabDiagnosticGroupSetupController cnt,BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: CustomDropDown(
                  labeltext: "Department",
                  id: cnt.cmb_departmentID.value,
                  list: cnt.department_list_temp
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    cnt.cmb_departmentID.value = v!;
                  })),
          width(),
          Expanded(
            flex: 6,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Service Urgency Name",
                controller: cnt.txt_group_name,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: cnt.cmb_groupStatusID.value,
              labeltext: "Status",
              list: cnt.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                cnt.cmb_groupStatusID.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            cnt.saveUpdateGroupSetup( context);
            // print("object");
            // controller.saveStoreType();
            //await controller.saveUpdateCategory();
          }, cnt.editGroupID.value == '' ? Icons.save_as_sharp : Icons.edit),
          width(),
          roundedButton(() {
            cnt.cmb_groupStatusID.value = "1";
            cnt.txt_group_name.text = '';
            // controller.editServiceCatID.value = '';
            //controller.txt_ServiceCatName.text = '';
            //controller.cmb_service_cat_status.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );
