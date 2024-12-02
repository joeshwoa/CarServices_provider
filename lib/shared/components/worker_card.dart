import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/manage%20workers/add_worker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WorkerCard extends StatelessWidget {
  final CompanyWorker worker;
  final int index;

  const WorkerCard({super.key, required this.worker, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ConstantColors.cardColor,
          border: Border.all(color: ConstantColors.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: ConstantColors.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ConstantColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(double.infinity),
                      child: worker.image != null
                          ? CachedNetworkImage(
                              imageUrl: worker.image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Image.asset(avatar))
                          : Image.asset(
                              avatar,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (worker.fullName ?? 'Missing Name'.tr).capitalize!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        '(${worker.username ?? "Missing Username".tr})',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: ConstantColors.primaryColor),
                      ),
                      Text(
                        (worker.title ?? "Missing Title".tr).capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ConstantColors.bodyColor),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(
                          () => AddWorkerScreen(
                                index: index,
                                enabled: false,
                              ),
                          arguments: {'type': 'edit'});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          color: Color(0xFF717276),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0)),
                          )),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(view),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'VIEW'.tr,
                              style: TextStyle(
                                color: ConstantColors.cardColor,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(
                          () => AddWorkerScreen(
                                index: index,
                              ),
                          arguments: {'type': 'edit'});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      color: Color(0xFF00A9DF),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.305,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(editFilled),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'EDIT'.tr,
                              style: TextStyle(
                                color: ConstantColors.cardColor,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.dialog(
                        DeletePopUp(
                          deletable: 'worker'.tr,
                        ),
                      ).then((result) async {
                        if (result) {
                          await Get.find<CompanyWorkersDetailsController>()
                              .deleteWorker(worker.id, index);
                          await Get.find<CompanyDetailsController>()
                              .getCompanyWorkers();
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          color: Color(0xFFDD0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(0)),
                          )),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(deleteFilled),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'DELETE'.tr,
                              style: TextStyle(
                                color: ConstantColors.cardColor,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
