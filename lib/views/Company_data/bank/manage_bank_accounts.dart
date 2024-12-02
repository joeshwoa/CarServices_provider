import 'package:autoflex/controllers/Company_data/banking/banking_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/shared/components/account_card.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/bank/add_bank_details.dart';
import 'package:autoflex/views/Company_data/manage%20workers/add_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iban/iban.dart';

class ManageBankAccountsScreen extends StatelessWidget {
  ManageBankAccountsScreen({super.key});
  final BankingController bankingController = Get.put(BankingController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: ConstantColors.backgroundColor,
              title: Text(
                'Manage bank accounts'.tr.toUpperCase(),
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
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    ...bankingController.accounts.map((account) => AccountCard(
                        id: account.id!,
                        bank: account.bankName ?? "",
                        name: account.accountTitle ?? "",
                        iban: toPrintFormat(account.iban ?? ""),
                        accountNumber: account.accountNumber ?? "")),
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                8), // Same as the button's shape
                          ),
                          child: TextButton.icon(
                            style: ButtonStyle(
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 12)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Same as the container's border radius
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                ConstantColors
                                    .primaryColor, // Button background color
                              ),
                              alignment: Get.locale!.languageCode == 'en'
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                            ),
                            onPressed: () {
                              Get.to(() => AddBankAccountScreen(),
                                  arguments: {'type': 'add'});
                            },
                            icon: SvgPicture.asset(
                              addWhite, // Icon color
                            ),
                            label: Text(
                              'Add New Account'.tr,
                              style: TextStyle(
                                color: ConstantColors.cardColor, // Text color
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.17,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          bankingController.loading.value ? const LoadingWidget() : const Row()
        ],
      ),
    );
  }
}
