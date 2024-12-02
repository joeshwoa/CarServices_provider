import 'package:autoflex/controllers/Company_data/banking/edit_bank_account_controller.dart';
import 'package:autoflex/controllers/Company_data/banking/banking_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/loadingButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBankAccountScreen extends StatelessWidget {
  AddBankAccountScreen({super.key});

  final BankingController bankingController = Get.find<BankingController>();
  final EditBankingController editBankingController =
      Get.put(EditBankingController());
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
  @override
  Widget build(BuildContext context) {
    final String type = Get.arguments['type'] ?? "add";
    // Populate the form if it's in edit mode
    return Obx(
      () {
        return Stack(
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
                  child: Form(
                    key: editBankingController.bankAccountFormKey,
                    child: Column(
                      children: [
                        textField(
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          hint: 'Bank Name'.tr,
                          context: context,
                          keyboardType: TextInputType.name,
                          controller:
                              editBankingController.bankNameController.value,
                          isPassword: false,
                          phoneField: false,
                          change: (value) {},
                          validate: (value) {
                            return Validations.validateName(value!, context);
                          },
                          disabled: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          hint: 'Account Title'.tr,
                          context: context,
                          keyboardType: TextInputType.name,
                          controller: editBankingController
                              .accountTitleController.value,
                          isPassword: false,
                          phoneField: false,
                          change: (value) {},
                          validate: (value) {
                            return Validations.validateName(value!, context);
                          },
                          disabled: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          hint: 'Account Number'.tr,
                          context: context,
                          keyboardType: TextInputType.number,
                          controller: editBankingController
                              .accountNumberController.value,
                          isPassword: false,
                          phoneField: false,
                          change: (value) {},
                          validate: (value) {
                            return Validations.validateAccountNum(
                                value!, context);
                          },
                          disabled: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          hint: 'IBAN'.tr,
                          context: context,
                          keyboardType: TextInputType.name,
                          controller:
                              editBankingController.ibanController.value,
                          isPassword: false,
                          phoneField: false,
                          change: (value) {},
                          validate: (value) {
                            return Validations.validateIBAN(value!, context);
                          },
                          disabled: false,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        type == 'add'
                            ? FormSubmitButton(
                                onPressed: () async {
                                  await editBankingController.createAccount();
                                  await companyDetailsController
                                      .getBankAccounts();
                                },
                                label: 'Save'.tr,
                                context: context)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Material(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ConstantColors.cardColor,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border: Border.all(
                                            color: ConstantColors
                                                .primaryColor, // Set the border color
                                            width: 1.0, // Set the border width
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            await editBankingController
                                                .updateAccount();
                                            await companyDetailsController
                                                .getBankAccounts();
                                          },
                                          color: ConstantColors.cardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                              child: Text(
                                                'Update'.tr,
                                                style: TextStyle(
                                                  color: ConstantColors
                                                      .primaryColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      localization == "en"
                                                          ? GoogleFonts.roboto()
                                                              .fontFamily
                                                          : 'DubaiFont',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Material(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Get.dialog(
                                            DeletePopUp(
                                              deletable: 'account'.tr,
                                            ),
                                          ).then((result) {
                                            if (result == true) {
                                              bankingController.deleteAccount(
                                                  Get.arguments['accountId']);
                                              Get.back();
                                            }
                                          });
                                        },
                                        color: ConstantColors.errorColor,
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Text(
                                            'Delete'.tr,
                                            style: TextStyle(
                                              color: ConstantColors.cardColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: localization == "en"
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
                                                  : 'DubaiFont',
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            editBankingController.loading.value
                ? const LoadingWidget()
                : const Row()
          ],
        );
      },
    );
  }
}
