import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: SvgPicture.asset(logo2),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your account is scheduled to be deleted in 15 days. '.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFF959699),
                      fontSize: 21,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.21,
                      overflow: TextOverflow.visible),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
