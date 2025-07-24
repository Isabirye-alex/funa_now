import 'dart:convert';

class OrderEmailModel {
    String receiver;
    String receiverName;
    String orderId;
    String orderDate;
    String paymentMethod;
    String shippingAddress;
    int total;
    List<OrderItem> orderItems;

    OrderEmailModel({
        required this.receiver,
        required this.receiverName,
        required this.orderId,
        required this.orderDate,
        required this.paymentMethod,
        required this.shippingAddress,
        required this.total,
        required this.orderItems,
    });

    OrderEmailModel copyWith({
        String? receiver,
        String? receiverName,
        String? orderId,
        String? orderDate,
        String? paymentMethod,
        String? shippingAddress,
        int? total,
        List<OrderItem>? orderItems,
    }) => 
        OrderEmailModel(
            receiver: receiver ?? this.receiver,
            receiverName: receiverName ?? this.receiverName,
            orderId: orderId ?? this.orderId,
            orderDate: orderDate ?? this.orderDate,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            shippingAddress: shippingAddress ?? this.shippingAddress,
            total: total ?? this.total,
            orderItems: orderItems ?? this.orderItems,
        );

    factory OrderEmailModel.fromRawJson(String str) => OrderEmailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderEmailModel.fromJson(Map<String, dynamic> json) => OrderEmailModel(
        receiver: json["receiver"],
        receiverName: json["receiverName"],
        orderId: json["orderId"],
        orderDate: json["orderDate"],
        paymentMethod: json["paymentMethod"],
        shippingAddress: json["shippingAddress"],
        total: json["total"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "receiver": receiver,
        "receiverName": receiverName,
        "orderId": orderId,
        "orderDate": orderDate,
        "paymentMethod": paymentMethod,
        "shippingAddress": shippingAddress,
        "total": total,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    };
}

class OrderItem {
    String name;
    int quantity;
    double price;
    String image;

    OrderItem({
        required this.name,
        required this.quantity,
        required this.price,
        required this.image,
    });

    OrderItem copyWith({
        String? name,
        int? quantity,
        double? price,
        String? image,
    }) => 
        OrderItem(
            name: name ?? this.name,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            image: image ?? this.image,
        );

    factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "image": image,
    };
}
