import 'package:autoflex/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

dynamic toast({
  required String message,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: ConstantColors.primaryColor,
        textColor: ConstantColors.backgroundColor,
        fontSize: 16.0);
