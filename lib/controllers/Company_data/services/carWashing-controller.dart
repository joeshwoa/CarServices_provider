import 'package:get/get.dart';

class CarWashingController extends GetxController {
  var carWashingItems=['Foam Wash'.tr,'Exterior Wash'.tr,'Detailing'.tr,'Shine Wash'.tr,'Disinfection'.tr].obs;
  var itemSelected=false.obs;
 var servisesRates=[
  {'name':'Sedan','description':'Also coupe, sport mini or similar'},
 {'name':'SUV (5 Seater)','description':'Also coupe, sport mini or similar'},
 {'name':'SUV (7 Seater)','description':'Also coupe, sport mini or similar'},
 {'name':'Motorcycle','description':'Also coupe, sport mini or similar'}].obs;
}