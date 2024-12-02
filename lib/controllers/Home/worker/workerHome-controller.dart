import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/models/workerHome/woker_orders.dart';
import 'package:autoflex/services/worker/workerHome_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkerHomeController extends GetxController {
  WorkerHomeController({this.pastJob = false});

  bool pastJob = false;
  var jobsTypes = ['Today’s Jobs'.tr, 'Future Jobs'.tr].obs;

  Rx<WorkerOrders> getWorkerOrders = WorkerOrders(data: []).obs;

  var selectedTab = 'Today’s Jobs'.tr.obs;

  var pastJobs = [
    {
      'status': "Completed",
      'orderId': '5246354653',
      'service': 'Car Wash',
      'date': '25 JUN 2023',
      'place': 'Sharjah (Al Majaz 2)',
      'price': 'AED 58.50'
    },
    {
      'status': "Completed",
      'orderId': '5246354653',
      'service': 'Car Wash',
      'date': '25 JUN 2023',
      'place': 'Sharjah (Al Majaz 2)',
      'price': 'AED 58.50'
    },
    {
      'status': "Completed",
      'orderId': '5246354653',
      'service': 'Car Wash',
      'date': '25 JUN 2023',
      'place': 'Sharjah (Al Majaz 2)',
      'price': 'AED 58.50'
    },
    {
      'status': "Canceled",
      'orderId': '5246354653',
      'service': 'Car Wash',
      'date': '25 JUN 2023',
      'place': 'Sharjah (Al Majaz 2)',
      'price': 'AED 58.50'
    },
    {
      'status': "Incomplete",
      'orderId': '5246354653',
      'service': 'Car Wash',
      'date': '25 JUN 2023',
      'place': 'Sharjah (Al Majaz 2)',
      'price': 'AED 58.50'
    },
  ].obs;
  var todayJobs = [
    {
      'orderId': '325665',
      'name': 'Abdul Kadir',
      'price': 'AED 58.50',
      'payType': 'Cash on Delivery',
      'date': 'Wednesday 5 MAY 2024',
      'time': '06:00 PM',
      'carType': 'Toyota Corolla 2022, Silver (Manual Gear)',
      'model': 'DXB - 1 - 52298',
      'address': 'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
      'place': 'Park inside building floor Maz-1.',
      'services': [
        'Full car body wash',
        'Interior Vacuum, Dust wiping & cleaning',
        'Light interior shining with special products and fragnance',
        'Tires and wheels wash and shine'
      ]
    },
    {
      'orderId': '325665',
      'name': 'Abdul Kadir',
      'price': 'AED 58.50',
      'payType': 'Cash on Delivery',
      'date': 'Wednesday 5 MAY 2024',
      'time': '06:00 PM',
      'carType': 'Toyota Corolla 2022, Silver (Manual Gear)',
      'model': 'DXB - 1 - 52298',
      'address': 'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
      'place': 'Park inside building floor Maz-1.',
      'services': [
        'Full car body wash',
        'Interior Vacuum, Dust wiping & cleaning',
        'Light interior shining with special products and fragnance',
        'Tires and wheels wash and shine'
      ]
    },
    {
      'orderId': '325665',
      'name': 'Abdul Kadir',
      'price': 'AED 58.50',
      'payType': 'Cash on Delivery',
      'date': 'Wednesday 5 MAY 2024',
      'time': '06:00 PM',
      'carType': 'Toyota Corolla 2022, Silver (Manual Gear)',
      'model': 'DXB - 1 - 52298',
      'address': 'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
      'place': 'Park inside building floor Maz-1.',
      'services': [
        'Full car body wash',
        'Interior Vacuum, Dust wiping & cleaning',
        'Light interior shining with special products and fragnance',
        'Tires and wheels wash and shine'
      ]
    },
    {
      'orderId': '325665',
      'name': 'Abdul Kadir',
      'price': 'AED 58.50',
      'payType': 'Cash on Delivery',
      'date': 'Wednesday 5 MAY 2024',
      'time': '06:00 PM',
      'carType': 'Toyota Corolla 2022, Silver (Manual Gear)',
      'model': 'DXB - 1 - 52298',
      'address': 'Sharjah - Al Majaz 1 209 - Al Marjan Building - Behind KFC.',
      'place': 'Park inside building floor Maz-1.',
      'services': [
        'Full car body wash',
        'Interior Vacuum, Dust wiping & cleaning',
        'Light interior shining with special products and fragnance',
        'Tires and wheels wash and shine'
      ]
    }
  ].obs;
  var loading = false.obs;
  var expandedStates = <int, bool>{}.obs;
  void toggleExpansion(int index) {
    if (expandedStates.containsKey(index)) {
      expandedStates[index] = !expandedStates[index]!;
    } else {
      expandedStates[index] = true;
    }
  }

  @override
  Future<void> onInit() async {
    await getOrders(pastJobs: pastJob);
    await getNotifications();
    super.onInit();
  }

  Future<void> getOrders({bool pastJobs = false}) async {
    loading.value = true;
    if (!pastJobs) {
      getWorkerOrders.value = await WorkerHomeServices.getOrders(
              todayJobs: selectedTab.value == 'Today’s Jobs'.tr,
              futureJobs: selectedTab.value == 'Future Jobs'.tr) ??
          WorkerOrders(data: []);
    } else {
      getWorkerOrders.value =
          await WorkerHomeServices.getOrders(pastJobs: true) ??
              WorkerOrders(data: []);
    }

    loading.value = false;
  }

  Future<void> changeStatus(id, status) async {
    loading.value = true;

    bool updateOrderStatusOrders =
        await WorkerHomeServices.updateOrderStatus(id, status);

    if (updateOrderStatusOrders) {
      int index = getWorkerOrders.value.data!.indexWhere(
        (element) => element.id == id,
      );
      getWorkerOrders.value.data![index].workerStatus = status;
      Get.back();
    } else {
      toast(message: 'Can not change order status'.tr);
    }

    loading.value = false;
  }

  var showNotification = false.obs;
  Notifications? getNotificationsRequest = Notifications(data: []);
  Rx<bool> unseenMessages = false.obs;
  Future<void> getNotifications() async {
    loading.value = true;

    getNotificationsRequest = await WorkerHomeServices.getNotifications();
    unseenMessages.value = (getNotificationsRequest!.totalUnseen! > 0);
    // Create a DateFormat object for the desired format

    loading.value = false;
  }
  Future<void> readAllNotifications() async {
    bool done = await WorkerHomeServices.readAllNotifications();
    if(done) {
      getNotificationsRequest!.totalUnseen = 0;
      unseenMessages.value = false;
    }
  }
}
