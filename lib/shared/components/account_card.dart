import 'package:autoflex/controllers/Company_data/banking/banking_controller.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/bank/add_bank_details.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AccountCard extends StatelessWidget {
  final String bank;
  final int id;
  final String name;
  final String iban;
  final String accountNumber;

  AccountCard(
      {super.key,
      required this.bank,
      required this.name,
      required this.iban,
      required this.accountNumber,
      required this.id});

  final BankingController? controller = Get.isRegistered<BankingController>()
      ? Get.find<BankingController>()
      : Get.put(BankingController());

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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank.capitalize!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        '($name)',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: ConstantColors.bodyColor),
                      ),
                      Text(
                        '${'IBAN:'.tr} $iban',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ConstantColors.bodyColor2),
                      ),
                      Text(
                        '${'Account Number:'.tr} $accountNumber',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ConstantColors.bodyColor2),
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
                      Get.to(() => AddBankAccountScreen(),
                          arguments: {'type': 'edit', 'accountId': id});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          color: Color(0xFF00A9DF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0)),
                          )),
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.dialog(
                        DeletePopUp(
                          deletable: 'account'.tr,
                        ),
                      ).then((result) {
                        if (result == true) {
                          controller!.deleteAccount(id);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          color: Color(0xFFDD0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(0)),
                          )),
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
                )
              ],
            )
          ],
        ));
  }
}
