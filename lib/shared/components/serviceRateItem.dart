import 'package:autoflex/controllers/Company_data/services/subcategory_controller.dart';
import 'package:autoflex/shared/components/auto_size_text_field_custom.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceRateItem extends StatelessWidget {
  final String? type;
  final int id;
  final String? description;
  final dynamic? context;

  ServiceRateItem({
    Key? key,
    this.type,
    this.description,
    this.context,
    required this.id,
  }) : super(key: key);

  final SubCategoryController controller = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        controller.addServiceRate(id);
      }
    });

    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      value: controller.itemsSelected[id - 1].value,
                      onChanged: (value) {
                        controller.itemsSelected[id - 1].value = value;
                        if (!value) {
                          controller.removeServiceRate(id);
                        }
                      },
                      activeColor: ConstantColors.secondaryColor,
                      inactiveThumbColor: ConstantColors.bodyColor,
                      activeTrackColor: ConstantColors.cardColor,
                      inactiveTrackColor: ConstantColors.cardColor,
                      trackOutlineColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (controller.itemsSelected[id - 1].value) {
                            return ConstantColors.secondaryColor;
                          }
                          return ConstantColors.bodyColor;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type!,
                      style: TextStyle(
                        fontSize: 9,
                        color: ConstantColors.bodyColor3,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 7,
                        color: ConstantColors.bodyColor,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                Column(
                  children: [
                    Text(
                      'Price (AED)'.tr,
                      style: TextStyle(
                        fontSize: 9,
                        color: ConstantColors.bodyColor3,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Including VAT'.tr,
                      style: TextStyle(
                        fontSize: 7,
                        color: ConstantColors.bodyColor,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                /*Container(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  width: 39,
                  height: 20,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    controller: controller.serviceRatesControllers[id - 1],
                    readOnly: !controller.itemsSelected[id - 1].value,
                    onEditingComplete: () {
                      controller.addServiceRate(id);
                    },
                    validator: (value) {
                      return Validations.validatePrice(value!, context);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      errorStyle: const TextStyle(
                          fontSize: 0), // Hides the error message text
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ConstantColors.errorColor,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.itemsSelected[id - 1].value
                              ? ConstantColors.primaryColor
                              : Color(0xFFE3E4E5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.itemsSelected[id - 1].value
                              ? ConstantColors.borderColor
                              : Color(0xFFE3E4E5),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),*/
                SizedBox(
                  width: 39,
                  height: 20,
                  child: AutoSizeTextFieldCustom(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    fullwidth: false,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    controller: controller.serviceRatesControllers[id - 1],
                    readOnly: !controller.itemsSelected[id - 1].value,
                    onEditingComplete: () {
                      controller.addServiceRate(id);
                    },
                    validator: (value) {
                      return Validations.validatePrice(value!, context);
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          fontSize: 0), // Hides the error message text
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ConstantColors.errorColor,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.itemsSelected[id - 1].value
                              ? ConstantColors.primaryColor
                              : Color(0xFFE3E4E5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.itemsSelected[id - 1].value
                              ? ConstantColors.borderColor
                              : Color(0xFFE3E4E5),
                          width: 1,
                        ),
                      ),
                    ),
                    minFontSize: 7,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
