import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/colors.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        color: ConstantColors.primaryColor,
        child: const Center(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )),
        ),
      ),
    );
  }
}
