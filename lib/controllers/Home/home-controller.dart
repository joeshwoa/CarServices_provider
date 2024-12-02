import 'dart:developer';

import 'package:autoflex/models/earning.dart';
import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/models/orders.dart';
import 'package:autoflex/services/company/home_services.dart';
import 'package:autoflex/services/ordersService.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../models/reviews.dart';

class HomeController extends GetxController {
  var isTileExpanded = false.obs;
  var loadingChartData = false.obs;
  var loadingNewOrders = false.obs;
  var showNotification = false.obs;
var loading=false.obs;
var jobsIsExpanded=false.obs;
var jobsHeight=60.0.obs;
var withdrawMessage=''.obs;
var buttonLoading=false.obs;

  var message = RemoteMessage().obs;
  var slots = [
    {"id": 1, "from": "12 AM", "to": "1 AM"},
    {"id": 2, "from": "1 AM", "to": "2 AM"},
    {"id": 3, "from": "2 AM", "to": "3 AM"},
    {"id": 4, "from": "3 AM", "to": "4 AM"},
    {"id": 5, "from": "4 AM", "to": "5 AM"},
    {"id": 6, "from": "5 AM", "to": "6 AM"},
    {"id": 7, "from": "6 AM", "to": "7 AM"},
    {"id": 8, "from": "7 AM", "to": "8 AM"},
    {"id": 9, "from": "8 AM", "to": "9 AM"},
    {"id": 10, "from": "9 AM", "to": "10 AM"},
    {"id": 11, "from": "10 AM", "to": "11 AM"},
    {"id": 12, "from": "11 AM", "to": "12 PM"},
    {"id": 13, "from": "12 PM", "to": "1 PM"},
    {"id": 14, "from": "1 PM", "to": "2 PM"},
    {"id": 15, "from": "2 PM", "to": "3 PM"},
    {"id": 16, "from": "3 PM", "to": "4 PM"},
    {"id": 17, "from": "4 PM", "to": "5 PM"},
    {"id": 18, "from": "5 PM", "to": "6 PM"},
    {"id": 19, "from": "6 PM", "to": "7 PM"},
    {"id": 20, "from": "7 PM", "to": "8 PM"},
    {"id": 21, "from": "8 PM", "to": "9 PM"},
    {"id": 22, "from": "9 PM", "to": "10 PM"},
    {"id": 23, "from": "10 PM", "to": "11 PM"},
    {"id": 24, "from": "11 PM", "to": "12 AM"}
  ];

  /*var newJobs=[
    {
      'time':'10:00 AM - 11:00 AM',
      'carType':'Toyota, Corolla (Car Wash, Waxing...)',
      'city':'Sharjah - Al Majaz 1'
    },
     {
      'time':'10:00 AM - 11:00 AM',
      'carType':'Toyota, Corolla (Car Wash, Waxing...)',
      'city':'Sharjah - Al Majaz 1'
    }
  ].obs;*/
  var reviews=<Review>[].obs;
  var totalReviews=0.obs;
  var averageReviews=0.0.obs;
  // [
  //   {
  //     'image':"assets/images/avatar.png",
  //     'name':'Mustafa Malik',
  //     'date':'13 Jul 2024',
  //     'review':'sdkfg sdfgsjgfhjsdg fjhsgd fjhsgdjf gsdjhfg dsjhfg sdjhfgsdjhfg dsjhfgdsjh fjsdg fjdhsg fjhgds jfhgsd fgsdjfg sdjhfg '
  //   },
  //   {
  //     'image':"assets/images/avatar.png",
  //     'name':'Mustafa Malik',
  //     'date':'13 Jul 2024',
  //     'review':'sdkfg sdfgsjgfhjsdg fjhsgd fjhsgdjf gsdjhfg dsjhfg sdjhfgsdjhfg dsjhfgdsjh fjsdg fjdhsg fjhgds jfhgsd fgsdjfg sdjhfg '
  //   },
  //   {
  //     'image':"assets/images/avatar.png",
  //     'name':'Mustafa Malik',
  //     'date':'13 Jul 2024',
  //     'review':'sdkfg sdfgsjgfhjsdg fjhsgd fjhsgdjf gsdjhfg dsjhfg sdjhfgsdjhfg dsjhfgdsjh fjsdg fjdhsg fjhgds jfhgsd fgsdjfg sdjhfg '
  //   }

  // ].obs;

  Earning? getEarningRequest = Earning();
  Notifications? getNotificationsRequest = Notifications(data: []);
  Rx<bool> unseenMessages = false.obs;
  // Rx<Orders> getAllNewOrdersRequest = Orders(data: <Datum>[].obs).obs;
  var newJobs=<Datum>[].obs;

  @override
  void onInit()async {
   await getChartData();
    await getNewJobs();
    await getReviews();
    await getNotifications();
    super.onInit();
  }

 Future<void> getChartData() async {
   loading.value = true;

   getEarningRequest = await HomeServices.getEarning();
   // Create a DateFormat object for the desired format

   loading.value = false;
 }
  Future<void> getNotifications() async {
    loading.value = true;

    getNotificationsRequest = await HomeServices.getNotifications();
    unseenMessages.value = (getNotificationsRequest!.totalUnseen! > 0);
    // Create a DateFormat object for the desired format

    loading.value = false;
  }
  Future<void> readAllNotifications() async {
    bool done = await HomeServices.readAllNotifications();
    if(done) {
      getNotificationsRequest!.totalUnseen = 0;
      unseenMessages.value = false;
    }
  }

  Future<void> withdraw() async {
   buttonLoading.value = true;

   withdrawMessage.value = await HomeServices.witdraw();
    buttonLoading.value = false;
toast(message: withdrawMessage.value);

  
 }
   Future<void> getReviews() async {
    loading.value = true;
var getReviewsRequest = await HomeServices.getReviews();
 reviews.value=getReviewsRequest!.data!.reviews!;
 totalReviews.value=getReviewsRequest!.data!.total!;
 averageReviews.value=getReviewsRequest!.data!.average!;
 // newJobs.value=<Datum>[Datum(id: 1,address: Address(address: ['test']), slotId: 1, vehicle: Vehicle(carBrand: CarBrand(name: 'test'), carModel: Car(name: 'test')))];
 inspect(reviews.value);
 

    loading.value = false;
  }

  Future<void> getNewJobs() async {
    loading.value = true;
var getAllNewOrdersRequest = await OrdersServices.getAllNewOrders();
 newJobs.value=getAllNewOrdersRequest!.data!;
 // newJobs.value=<Datum>[Datum(id: 1,address: Address(address: ['test']), slotId: 1, vehicle: Vehicle(carBrand: CarBrand(name: 'test'), carModel: Car(name: 'test')))];
 inspect(newJobs.value);
    // Create a DateFormat object for the desired format

    loading.value = false;
  }

  Future<void> changeStatusNewJobs(int index,String status) async {

    int id = newJobs.value[index].id!;
    Datum order = newJobs.value[index];
    order.status = status;
buttonLoading.value=true;
    bool success = await OrdersServices.editOrder(id: id, order: order);
    if(success) {
toast(message: '${'job successfully'.tr} ${status}');
  newJobs.value.removeAt(index);
newJobs.refresh();
buttonLoading.value=false;
    }
    // Create a DateFormat object for the desired format


  }
}