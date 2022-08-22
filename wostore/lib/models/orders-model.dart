import 'package:netflix/models/product-model.dart';

class Orders {
    Orders({
        this.id,
        this.date,
        this.paymentStatus,
        this.deliveryStatus,
        this.orderStatus,
        this.discount,
        this.total,
        this.payableAmount,
        this.customer,
        this.billingAddress,
        this.payment,
        this.orderProducts,
    });

    int id;
    DateTime date;
    String paymentStatus;
    String deliveryStatus;
    String orderStatus;
    int discount;
    int total;
    int payableAmount;
    Customer customer;
    BillingAddress billingAddress;
    Payment payment;
    List<OrderProduct> orderProducts;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
        deliveryStatus: json["delivery_status"] == null ? null : json["delivery_status"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        discount: json["discount"] == null ? null : json["discount"],
        total: json["total"] == null ? null : json["total"],
        payableAmount: json["payable_amount"] == null ? null : json["payable_amount"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        orderProducts: json["order_products"] == null ? null : List<OrderProduct>.from(json["order_products"].map((x) => OrderProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "delivery_status": deliveryStatus == null ? null : deliveryStatus,
        "order_status": orderStatus == null ? null : orderStatus,
        "discount": discount == null ? null : discount,
        "total": total == null ? null : total,
        "payable_amount": payableAmount == null ? null : payableAmount,
        "customer": customer == null ? null : customer.toJson(),
        "billing_address": billingAddress == null ? null : billingAddress.toJson(),
        "payment": payment == null ? null : payment.toJson(),
        "order_products": orderProducts == null ? null : List<dynamic>.from(orderProducts.map((x) => x.toJson())),
    };
}

class BillingAddress {
    BillingAddress({
        this.id,
        this.billingAddressName,
        this.address,
        this.city,
        this.state,
        this.pincode,
        this.country,
        this.mobileNumber,
    });

    int id;
    String billingAddressName;
    String address;
    String city;
    String state;
    String pincode;
    String country;
    String mobileNumber;

    factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        id: json["id"] == null ? null : json["id"],
        billingAddressName: json["billing_address_name"] == null ? null : json["billing_address_name"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        country: json["country"] == null ? null : json["country"],
        mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "billing_address_name": billingAddressName == null ? null : billingAddressName,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pincode": pincode == null ? null : pincode,
        "country": country == null ? null : country,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
    };
}

class Customer {
    Customer({
        this.id,
        this.fullName,
        this.address,
        this.locality,
        this.city,
        this.state,
        this.pincode,
        this.country,
        this.mobileNumber,
        this.email,
        this.gender,
        this.password,
    });

    int id;
    String fullName;
    String address;
    String locality;
    String city;
    String state;
    String pincode;
    String country;
    String mobileNumber;
    String email;
    String gender;
    String password;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        address: json["address"] == null ? null : json["address"],
        locality: json["locality"] == null ? null : json["locality"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        country: json["country"] == null ? null : json["country"],
        mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        password: json["password"] == null ? null : json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "full_name": fullName == null ? null : fullName,
        "address": address == null ? null : address,
        "locality": locality == null ? null : locality,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pincode": pincode == null ? null : pincode,
        "country": country == null ? null : country,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "password": password == null ? null : password,
    };
}

class OrderProduct {
    OrderProduct({
        this.id,
        this.unitPrice,
        this.quantity,
        this.total,
        this.product,
        this.variant,
    });

    int id;
    int unitPrice;
    int quantity;
    int total;
    Product product;
    Variant variant;

    factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"] == null ? null : json["id"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        total: json["total"] == null ? null : json["total"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "unit_price": unitPrice == null ? null : unitPrice,
        "quantity": quantity == null ? null : quantity,
        "total": total == null ? null : total,
        "product": product == null ? null : product.toJson(),
        "variant": variant == null ? null : variant.toJson(),
    };
}

class Payment {
    Payment({
        this.id,
        this.txnId,
        this.date,
    });

    int id;
    String txnId;
    DateTime date;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"] == null ? null : json["id"],
        txnId: json["txn_id"] == null ? null : json["txn_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "txn_id": txnId == null ? null : txnId,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}