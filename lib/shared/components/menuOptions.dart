
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';
import '../styles/icons_assets.dart';

class MenuOption extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback? onPressed;
  const MenuOption(
      {super.key, required this.label, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          ),
          icon: SvgPicture.asset(icon),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    const SizedBox(
                        width:
                            8), // Adjust the width for desired space between icon and label
                    Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ConstantColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Get.locale?.languageCode == 'en'
                  ? SvgPicture.asset(
                  navigateNext,
                color: ConstantColors.bodyColor,)
                  : Transform.rotate(
                angle: 3.14,
                child: SvgPicture.asset(
                    navigateNext,
                  color: ConstantColors.bodyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
