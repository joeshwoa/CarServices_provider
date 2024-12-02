import 'dart:developer';

import 'package:autoflex/models/orders.dart';
import 'package:autoflex/services/ordersService.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Home/provider/manageJobs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/company workers/company_workers.dart';
import '../../services/company/company_workers_services.dart';

class ManageJobsController extends GetxController {
  var jobsTabs = ['Pending'.tr, 'Assigned'.tr, 'In Process'.tr].obs;
  var selectedTab = 'Pending'.tr.obs;
  var loading = false.obs;
  var popUpLoading = false.obs;
  var workers = <CompanyWorker>[].obs;
  Orders getAllOrdersRequest = Orders(data: []);
  // var workers = [
  //   {'name': 'Masood Khan', 'jobsNumber': 2},
  //   {'name': 'Imtiaz Ahmad', 'jobsNumber': 1},
  //   {'name': 'Masood Khan', 'jobsNumber': 2}
  // ].obs;
  var pendingJobs = <Datum>[].obs;
  var assignedJobs = <Datum>[].obs;
  var inProcessJobs = <Datum>[].obs;

  // var pendingJobs=[
  //   {
  //     'orderId':'325665',
  //     'name':'Abdul Kadir',
  //     'price':'AED 58.50',
  //     'payType':'Cash on Delivery',
  //     'date':'Wednesday 5 MAY 2024',
  //     'time':'06:00 PM',
  //     'carType':'Toyota Corolla 2022, Silver (Manual Gear)',
  //     'model':'DXB - 1 - 52298',
  //     'address':'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
  //     'place':'Park inside building floor Maz-1.',
  //     'services':[
  //       'Full car body wash',
  //       'Interior Vacuum, Dust wiping & cleaning',
  //       'Light interior shining with special products and fragnance',
  //       'Tires and wheels wash and shine'
  //     ]

  //   },
  // {
  //     'orderId':'325665',
  //     'name':'Abdul Kadir',
  //     'price':'AED 58.50',
  //     'payType':'Cash on Delivery',
  //     'date':'Wednesday 5 MAY 2024',
  //     'time':'06:00 PM',
  //     'carType':'Toyota Corolla 2022, Silver (Manual Gear)',
  //     'model':'DXB - 1 - 52298',
  //     'address':'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
  //     'place':'Park inside building floor Maz-1.',
  //     'services':[
  //       'Full car body wash',
  //       'Interior Vacuum, Dust wiping & cleaning',
  //       'Light interior shining with special products and fragnance',
  //       'Tires and wheels wash and shine'
  //     ]

  //   },
  //   {
  //     'orderId':'325665',
  //     'name':'Abdul Kadir',
  //     'price':'AED 58.50',
  //     'payType':'Cash on Delivery',
  //     'date':'Wednesday 5 MAY 2024',
  //     'time':'06:00 PM',
  //     'carType':'Toyota Corolla 2022, Silver (Manual Gear)',
  //     'model':'DXB - 1 - 52298',
  //     'address':'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
  //     'place':'Park inside building floor Maz-1.',
  //     'services':[
  //       'Full car body wash',
  //       'Interior Vacuum, Dust wiping & cleaning',
  //       'Light interior shining with special products and fragnance',
  //       'Tires and wheels wash and shine'
  //     ]

  //   },
  //   {
  //     'orderId':'325665',
  //     'name':'Abdul Kadir',
  //     'price':'AED 58.50',
  //     'payType':'Cash on Delivery',
  //     'date':'Wednesday 5 MAY 2024',
  //     'time':'06:00 PM',
  //     'carType':'Toyota Corolla 2022, Silver (Manual Gear)',
  //     'model':'DXB - 1 - 52298',
  //     'address':'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
  //     'place':'Park inside building floor Maz-1.',
  //     'services':[
  //       'Full car body wash',
  //       'Interior Vacuum, Dust wiping & cleaning',
  //       'Light interior shining with special products and fragnance',
  //       'Tires and wheels wash and shine'
  //     ]

  //   }

  // ].obs;
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

  var expandedStates = <int, bool>{}.obs;

  int selectedOrder = -1;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllOrders();
    if(Get.arguments != null) {
      print(Get.arguments);
      int index = getAllOrdersRequest.data!.indexWhere((element) => element.id == Get.arguments['order_id'],);
      if(index!= -1) {
        String status = getAllOrdersRequest.data![index].status!;
        selectedTab.value = status == 'pending' || status == 'accepted' ? 'Pending'.tr : status == 'assigned' ? 'Assigned'.tr : 'In Process'.tr;
        int indexInState = -1;
        for (var element in getAllOrdersRequest.data!) {
          if (element.status == status) {
            indexInState++;
            if(element.id == Get.arguments['order_id']) {
              selectedOrder = indexInState;
              break;
            }
          }
        }
        if (indexInState != -1) {
          expandedStates[indexInState] = true;

          /*WidgetsBinding.instance.addPostFrameCallback((_) {
            Scrollable.ensureVisible(ManageJobsScreen.orderGlobalKey.currentContext!,
                duration: Duration(seconds: 1), curve: Curves.easeInOut);
          });*/
        }
        /*ManageJobsScreen().scrollToOrderById(indexInState);*/
      }
    }
  }

  assignWorker(id, workerId) async {
    var assignWorkerRequest =
        await OrdersServices.assignOrder(id: id, workerId: workerId);
    inspect(assignWorkerRequest!.data);
    if (assignWorkerRequest!.data != null) {
      Get.back();
      toast(message: 'Job successfully assigned to worker');
      pendingJobs.value.clear();
      assignedJobs.value.clear();
      inProcessJobs.value.clear();
      getAllOrders();
    }
  }

  getWorkers(date, service) async {
    popUpLoading.value = true;

    var getCompanyWorkersRequest =
        await CompanyWorkersServices.getCompanyWorkerswithfilter(service, date);
    if (getCompanyWorkersRequest != null) {
      workers.value = getCompanyWorkersRequest!.data!;
      inspect(workers);
    } else {
      // toast(message: 'Could not Find Service Areas');
    }
    popUpLoading.value = false;
  }

  void toggleExpansion(int index) {
    if (expandedStates.containsKey(index)) {
      expandedStates[index] = !expandedStates[index]!;
    } else {
      expandedStates[index] = true;
    }
  }

  getAllOrders() async {
    loading.value = true;
    getAllOrdersRequest = await OrdersServices.getAllOrders()??Orders(data: []);
    for (var i = 0; i < getAllOrdersRequest.data!.length; i++) {
      if (getAllOrdersRequest.data![i].status == 'pending' ||
          getAllOrdersRequest.data![i].status == 'accepted') {
        pendingJobs.value.add(getAllOrdersRequest.data![i]);
      } else if (getAllOrdersRequest.data![i].status == 'assigned') {
        assignedJobs.value.add(getAllOrdersRequest.data![i]);
      } else {
        inProcessJobs.value.add(getAllOrdersRequest.data![i]);
      }
    }
    if (Get.arguments != null) {
      for (var i = 0; i < pendingJobs.length; i++) {
        if (Get.arguments['jobId'] == pendingJobs[i].id!) {
          expandedStates[i] = true;
        }
      }
    }
    inspect(getAllOrdersRequest.data!);
    inspect(assignedJobs.value);
      loading.value = false;
  }
}
