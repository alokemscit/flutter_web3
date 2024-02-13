// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';

import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/Inventory/pages/attribute_setup_page/controller/inventory_attribute_controller.dart';

class InvAttributeSetup extends StatelessWidget {
  const InvAttributeSetup({super.key});
  void disposeController() {
    try {
      Get.delete<InvmsAttributeController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    InvmsAttributeController controller =
        Get.put(InvmsAttributeController(context: context));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _mobile(controller),
            _tablet(controller),
            _desktop(controller)),
      ),
    );
  }
}

// ignore: non_constant_identifier_names

_mobile(InvmsAttributeController controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _groupPart(controller),
            height(),
            _subGroupPart(controller)
          ],
        ),
      ),
    );

_tablet(InvmsAttributeController controller) => Container();
_desktop(InvmsAttributeController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _StoreTypePart(controller),
              ),
              width(),
              Expanded(
                flex: 5,
                child: _groupPart(controller),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          height(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: _subGroupPart(controller),
              ),
            ],
          )
        ],
      ),
    );

_StoreTypePart(InvmsAttributeController controller) =>
    CustomAccordionContainer(headerName: "Store Type", children: [
      _StoreTypeEnryPart(controller),
      _StoreTypeTablePart(controller)
    ]);

_StoreTypeTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBox(
                      // borderRadious: 12,
                      labelTextColor: kGrayColor,
                      isFilled: true,
                      caption: "Search Store Type",
                      controller: controller.txt_StoreTypeSearch,
                      onChange: (v) {
                        controller.searchStoreType();
                      }),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(130),
                    1: FlexColumnWidth(80),
                    2: FlexColumnWidth(30),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        CustomTableCell("Name"),
                        CustomTableCell("Status"),
                        CustomTableCell("Action"),
                      ],
                    ),
                    for (var i = 0;
                        i < controller.storeTypeList_temp.length;
                        i++)
                      TableRow(
                          decoration: BoxDecoration(
                            color: controller.editStoreTypeID.value !=
                                    controller.storeTypeList_temp[i].id
                                ? Colors.white
                                : Colors.amber.withOpacity(0.3),
                          ),
                          children: [
                            CustomTableCell(
                                controller.storeTypeList_temp[i].name!),
                            CustomTableCell(
                                controller.storeTypeList_temp[i].status == '1'
                                    ? "Active"
                                    : "Inactive"),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    controller.editStoreTypeID.value =
                                        controller.storeTypeList_temp[i].id!;
                                    controller.txt_StoreType.text =
                                        controller.storeTypeList_temp[i].name!;
                                    controller.cmb_StoreTypeStatusId.value =
                                        controller
                                            .storeTypeList_temp[i].status!;
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: kWebHeaderColor,
                                      size: 12,
                                    ),
                                  ),
                                )),
                          ])
                  ],
                  border: CustomTableBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );

_StoreTypeEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                maxlength: 100,
                caption: "Store Type Name",
                controller: controller.txt_StoreType,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_StoreTypeStatusId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_StoreTypeStatusId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");
            controller.saveStoreType();
            //await controller.saveUpdateCategory();
          },
              controller.editStoreTypeID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editStoreTypeID.value = '';
            controller.txt_StoreType.text = '';
            controller.cmb_StoreTypeStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_groupPart(InvmsAttributeController controller) => CustomAccordionContainer(
    headerName: "Item Group",
    children: [_groupEnryPart(controller), _groupTablePart(controller)]);

_groupEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomDropDown(
                id: controller.cmb_StoreTypeId2.value,
                labeltext: "Store Type",
                list: controller.storeTypeList
                    .map((element) => DropdownMenuItem<String>(
                        value: element.id, child: Text(element.name!)))
                    .toList(),
                onTap: (v) {
                  controller.cmb_StoreTypeId2.value = v.toString();
                },
                width: 90),
          ),
          width(),
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Category Name",
                controller: controller.txt_Group,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_GroupStatusId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_GroupStatusId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");
            controller.saveGroup();
            //await controller.saveUpdateCategory();
          },
              controller.editGroupId.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.cmb_StoreTypeId2.value = '';
            controller.editGroupId.value = '';
            controller.txt_Group.text = '';
            controller.cmb_GroupStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_groupTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBox(
                      caption: "Search Group",
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(130),
                    1: FlexColumnWidth(80),
                    2: FlexColumnWidth(30),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        CustomTableCell("Name"),
                        CustomTableCell("Status"),
                        CustomTableCell("Action"),
                      ],
                    ),
                    for (var i = 0; i < controller.groupList.length; i++)
                      TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: [
                            CustomTableCell(controller.groupList[i].name!),
                            CustomTableCell(
                                controller.groupList[i].status == '1'
                                    ? "Active"
                                    : "Inactive"),
                            const TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Icon(Icons.edit)),
                          ])
                  ],
                  border: CustomTableBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );

_subGroupEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomDropDown(
              id: controller.cmb_GroupId2.value,
              labeltext: "Item Group",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_GroupId.value = v.toString();
              },
            ),
          ),
          width(),
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Item Sub Group Name",
                controller: controller.txt_SubGroup,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_SubGroupId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_SubGroupId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");

            //await controller.saveUpdateCategory();
          },
              controller.editSubGroupID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editGroupId.value = '';
            controller.txt_SubGroup.text = '';
            controller.cmb_GroupStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_subGroupPart(InvmsAttributeController controller) =>
    CustomAccordionContainer(headerName: "Item Sub Group", children: [
      _subGroupEnryPart(controller),
    ]);
