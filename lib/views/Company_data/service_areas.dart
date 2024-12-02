import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/controllers/Company_data/service_areas_controller.dart';
import 'package:autoflex/models/work%20areas/areas.dart';
import 'package:autoflex/shared/components/custom_checkbox.dart';
import 'package:autoflex/shared/components/custom_switch.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/shared/workingHoursValidations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ServiceAreasScreen extends StatelessWidget {
  ServiceAreasScreen({super.key});
  final ServiceAreasController controller = Get.put(ServiceAreasController());
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        onPopInvoked: (value) {
          Get.delete<ServiceAreasController>();
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: ConstantColors.backgroundColor,
              title: Text(
                'Manage Service Areas'.tr.toUpperCase(),
                style: const TextStyle(
                  color: ConstantColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.17,
                ),
              ),
              leading: IconButton(
                icon: Get.locale?.languageCode == 'en'
                    ? SvgPicture.asset(arrowBack)
                    : Transform.rotate(
                  angle: 3.14,
                  child: SvgPicture.asset(arrowBack),
                ),
                onPressed: () {
                  Get.back();
                  Get.delete<ServiceAreasController>();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: controller.loading.value
                    ? Column(
                        children: List.generate(
                            7,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white),
                                      height: 70,
                                      width: double.infinity,
                                    ),
                                  ),
                                )),
                      )
                    : Column(
                        children: [
                          ...controller.emrites.map<Widget>((emrite) {
                            int index = controller.emrites.indexOf(emrite);
                            return Form(
                              key: controller.serviceAreasFormKeys[index],
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: ConstantColors.cardColor,
                                  border: Border.all(
                                      color: ConstantColors.borderColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                foregroundDecoration: BoxDecoration(
                                  border: Border.all(
                                      color: controller.isEmriteChecked[index]
                                          ? ConstantColors.secondaryColor
                                          : ConstantColors.borderColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: ExpansionPanelList(
                                  dividerColor:
                                      const Color.fromARGB(255, 238, 239, 241),
                                  elevation: 1,
                                  expandedHeaderPadding: EdgeInsets.zero,
                                  expansionCallback:
                                      (int panelIndex, bool isExpanded) {
                                    controller.isExpanded[index] =
                                        !controller.isExpanded[index];
                                  },
                                  children: [
                                    ExpansionPanel(
                                      backgroundColor: ConstantColors.cardColor,
                                      // hasIcon: false,
                                      headerBuilder: (BuildContext context,
                                          bool isExpanded) {
                                        return Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  start: 12),
                                              child: CustomCheckbox(
                                                value: controller
                                                    .isEmriteChecked[index],
                                                index: index,
                                                onChanged: (index) {
                                                  controller.loading.value =
                                                      true;
                                                  controller.isEmriteChecked[
                                                          index] =
                                                      !controller
                                                              .isEmriteChecked[
                                                          index];
                                                  controller.loading.value =
                                                      false;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: ListTile(
                                                title: Text(
                                                  emrite['name'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: ConstantColors
                                                              .bodyColor),
                                                ),
                                              ),
                                            ),
                                            Transform.scale(
                                              scale: 1.4,
                                              child: CustomSwitch(
                                                value: controller
                                                    .isSwitched[index],
                                                onChanged: (bool value) {
                                                  controller.isSwitched[index] =
                                                      value;
                                                  controller.isCityChecked[
                                                      index] = List.generate(
                                                    controller
                                                        .isCityChecked[index]
                                                        .length,
                                                    (_) => value,
                                                  );
                                                  if (value) {
                                                    controller.isEmriteChecked[
                                                        index] = true;
                                                  }
                                                  controller
                                                      .addServiceAreas(index);
                                                },
                                              ),
                                            ),
                                            Text(
                                              'Cover all areas?'.tr,
                                              style: TextStyle(
                                                color: Color(0xFF292B33),
                                                fontSize: 9,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: -0.09,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            )
                                          ],
                                        );
                                      },
                                      body: Column(
                                        children: [
                                          ...emrite['cities']
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            int j = entry.key;
                                            var city = entry.value as Area;
                                            return Column(
                                              children: [
                                                const Divider(
                                                  height: 1,
                                                  indent: 12,
                                                  endIndent: 12,
                                                  color: Color.fromARGB(
                                                      255, 226, 225, 225),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.only(
                                                              start: 12),
                                                      child: CustomCheckbox(
                                                        value: controller
                                                                .isCityChecked[
                                                            index][j],
                                                        index: index,
                                                        onChanged: (index) {
                                                          controller.checkCity(
                                                              index, j);
                                                          if (!controller
                                                                      .isEmriteChecked[
                                                                  index] &&
                                                              controller
                                                                      .isCityChecked[
                                                                  index][j]) {
                                                            controller
                                                                    .isEmriteChecked[
                                                                index] = true;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListTile(
                                                        title: Text(
                                                          (city.name ??
                                                                  'Missing Area Name'.tr)
                                                              .capitalize!,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF292B33),
                                                            fontSize: 11,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.11,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 54,
                                                      child: textField(
                                                        borderColor:
                                                            ConstantColors
                                                                .secondaryColor,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 8),
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontSize:
                                                                        11),
                                                        hint: 'HH:MM'.tr,
                                                        context: context,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        controller: controller
                                                                .controllers[
                                                            index][j],
                                                        isPassword: false,
                                                        phoneField: false,
                                                        change: (value) {
                                                          controller
                                                              .addServiceAreas(
                                                                  index);
                                                        },
                                                        validate: (value) {
                                                          return WorkingHoursValidations
                                                              .validateBreakHours(
                                                                  value!,
                                                                  context,
                                                                  null,
                                                                  controller
                                                                          .isCityChecked[
                                                                      index][j]);
                                                        },
                                                        disabled: !controller
                                                                .isCityChecked[
                                                            index][j],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 8),
                                                      child: Text(
                                                        'Reach Time'.tr,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF292B33),
                                                          fontSize: 9,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: -0.09,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          })
                                        ],
                                      ),
                                      isExpanded: controller.isExpanded[index],
                                      canTapOnHeader: true,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          const SizedBox(
                            height: 16,
                          ),
                          FormSubmitButton(
                              onPressed: () async {
                                await controller.updateServiceAreas();
                                await companyDetailsController
                                    .getServiceAreas();
                              },
                              label: 'Save'.tr)
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
