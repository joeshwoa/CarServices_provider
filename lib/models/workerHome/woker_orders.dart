// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WorkerOrders workerOrdersFromJson(String str) => WorkerOrders.fromJson(json.decode(str));

String workerOrdersToJson(WorkerOrders data) => json.encode(data.toJson());

class WorkerOrders {
  List<Datum>? data;

  WorkerOrders({
    this.data,
  });

  factory WorkerOrders.fromJson(Map<String, dynamic> json) => WorkerOrders(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? status;
  String? workerStatus;
  String? paymentMethod;
  String? customerName;
  String? customerPhone;
  String? customerWhatsappNumber;
  String? price;
  DateTime? date;
  String? day;
  int? slotId;
  Vehicle? vehicle;
  Address? address;
  List<DatumAddOn>? addOns;
  Product? product;
  Worker? worker;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    this.id,
    this.status,
    this.workerStatus,
    this.paymentMethod,
    this.customerName,
    this.customerPhone,
    this.customerWhatsappNumber,
    this.price,
    this.date,
    this.day,
    this.slotId,
    this.vehicle,
    this.address,
    this.addOns,
    this.product,
    this.worker,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    status: json["status"],
    workerStatus: json["worker_status"],
    paymentMethod: json["payment_method"],
    customerName: json["customer_name"],
    customerPhone: json["customer_phone"],
    customerWhatsappNumber: json["customer_whatsapp_number"],
    price: json["price"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    slotId: json["slot_id"],
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    addOns: json["add_ons"] == null ? [] : List<DatumAddOn>.from(json["add_ons"]!.map((x) => DatumAddOn.fromJson(x))),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    worker: json["worker"] == null ? null : Worker.fromJson(json["worker"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "worker_status": workerStatus,
    "payment_method": paymentMethod,
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "customer_whatsapp_number": customerWhatsappNumber,
    "price": price,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day,
    "slot_id": slotId,
    "vehicle": vehicle?.toJson(),
    "address": address?.toJson(),
    "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
    "product": product?.toJson(),
    "worker": worker?.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class DatumAddOn {
  int? id;
  int? qty;
  String? name;
  int? price;

  DatumAddOn({
    this.id,
    this.qty,
    this.name,
    this.price,
  });

  factory DatumAddOn.fromJson(Map<String, dynamic> json) => DatumAddOn(
    id: json["id"],
    qty: json["qty"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
    "name": name,
    "price": price,
  };
}

class Address {
  int? id;
  String? addressType;
  dynamic parentAddressId;
  int? customerId;
  dynamic cartId;
  dynamic orderId;
  String? firstName;
  String? lastName;
  dynamic gender;
  String? companyName;
  List<String>? address;
  String? city;
  String? state;
  String? country;
  String? postcode;
  String? email;
  String? phone;
  dynamic vatId;
  bool? defaultAddress;
  bool? useForShipping;
  List<dynamic>? additional;

  Address({
    this.id,
    this.addressType,
    this.parentAddressId,
    this.customerId,
    this.cartId,
    this.orderId,
    this.firstName,
    this.lastName,
    this.gender,
    this.companyName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.email,
    this.phone,
    this.vatId,
    this.defaultAddress,
    this.useForShipping,
    this.additional,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addressType: json["address_type"],
    parentAddressId: json["parent_address_id"],
    customerId: json["customer_id"],
    cartId: json["cart_id"],
    orderId: json["order_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    companyName: json["company_name"],
    address: json["address"] == null ? [] : List<String>.from(json["address"]!.map((x) => x)),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    email: json["email"],
    phone: json["phone"],
    vatId: json["vat_id"],
    defaultAddress: json["default_address"],
    useForShipping: json["use_for_shipping"],
    additional: json["additional"] == null ? [] : List<dynamic>.from(json["additional"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_type": addressType,
    "parent_address_id": parentAddressId,
    "customer_id": customerId,
    "cart_id": cartId,
    "order_id": orderId,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "company_name": companyName,
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "email": email,
    "phone": phone,
    "vat_id": vatId,
    "default_address": defaultAddress,
    "use_for_shipping": useForShipping,
    "additional": additional == null ? [] : List<dynamic>.from(additional!.map((x) => x)),
  };
}

class Product {
  int? id;
  dynamic name;
  String? sku;
  int? price;
  String? formattedPrice;
  List<String>? description;
  List<String>? additionalInformation;
  List<ProductAddOn>? addOns;
  String? duration;
  int? powerOutlet;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.sku,
    this.price,
    this.formattedPrice,
    this.description,
    this.additionalInformation,
    this.addOns,
    this.duration,
    this.powerOutlet,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    price: json["price"],
    formattedPrice: json["formatted_price"],
    description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
    additionalInformation: json["additional_information"] == null ? [] : List<String>.from(json["additional_information"]!.map((x) => x)),
    addOns: json["add_ons"] == null ? [] : List<ProductAddOn>.from(json["add_ons"]!.map((x) => ProductAddOn.fromJson(x))),
    duration: json["duration"],
    powerOutlet: json["power_outlet"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "price": price,
    "formatted_price": formattedPrice,
    "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
    "additional_information": additionalInformation == null ? [] : List<dynamic>.from(additionalInformation!.map((x) => x)),
    "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
    "duration": duration,
    "power_outlet": powerOutlet,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class ProductAddOn {
  int? id;
  String? name;
  int? price;
  String? formattedPrice;
  String? description;
  bool? multiQty;
  int? productId;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductAddOn({
    this.id,
    this.name,
    this.price,
    this.formattedPrice,
    this.description,
    this.multiQty,
    this.productId,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductAddOn.fromJson(Map<String, dynamic> json) => ProductAddOn(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    formattedPrice: json["formatted_price"],
    description: json["description"],
    multiQty: json["multi_qty"],
    productId: json["product_id"],
    sellerId: json["seller_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "formatted_price": formattedPrice,
    "description": description,
    "multi_qty": multiQty,
    "product_id": productId,
    "seller_id": sellerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Vehicle {
  int? id;
  Car? carType;
  CarBrand? carBrand;
  Car? carModel;
  int? emirateId;
  String? gearType;
  String? color;
  int? year;
  String? plateCode;
  String? plateNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehicle({
    this.id,
    this.carType,
    this.carBrand,
    this.carModel,
    this.emirateId,
    this.gearType,
    this.color,
    this.year,
    this.plateCode,
    this.plateNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"],
    carType: json["car_type"] == null ? null : Car.fromJson(json["car_type"]),
    carBrand: json["car_brand"] == null ? null : CarBrand.fromJson(json["car_brand"]),
    carModel: json["car_model"] == null ? null : Car.fromJson(json["car_model"]),
    emirateId: json["emirate_id"],
    gearType: json["gear_type"],
    color: json["color"],
    year: json["year"],
    plateCode: json["plate_code"],
    plateNumber: json["plate_number"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_type": carType?.toJson(),
    "car_brand": carBrand?.toJson(),
    "car_model": carModel?.toJson(),
    "emirate_id": emirateId,
    "gear_type": gearType,
    "color": color,
    "year": year,
    "plate_code": plateCode,
    "plate_number": plateNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class CarBrand {
  int? id;
  String? name;

  CarBrand({
    this.id,
    this.name,
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) => CarBrand(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Car {
  int? id;
  String? name;
  int? carBrandId;

  Car({
    this.id,
    this.name,
    this.carBrandId,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    name: json["name"],
    carBrandId: json["car_brand_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "car_brand_id": carBrandId,
  };
}

class Worker {
  int? id;
  String? username;
  String? fullName;
  String? phone;
  String? whatsappNumber;
  int? companyId;
  String? title;
  String? image;
  List<Category>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  Worker({
    this.id,
    this.username,
    this.fullName,
    this.phone,
    this.whatsappNumber,
    this.companyId,
    this.title,
    this.image,
    this.categories,
    this.createdAt,
    this.updatedAt,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    phone: json["phone"],
    whatsappNumber: json["whatsapp_number"],
    companyId: json["company_id"],
    title: json["title"],
    image: json["image"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "full_name": fullName,
    "phone": phone,
    "whatsapp_number": whatsappNumber,
    "company_id": companyId,
    "title": title,
    "image": image,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Category {
  int? id;
  dynamic name;
  dynamic slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
