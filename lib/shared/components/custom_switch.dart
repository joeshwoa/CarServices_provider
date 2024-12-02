import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 28, // Adjust width as needed
        height: 20, // Adjust height as needed
        child: Stack(
          children: [
            SvgPicture.asset(
              widget.value
                  ? 'assets/images/toggle_on.svg'
                  : 'assets/images/toggle_off.svg',
              width: 40,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
