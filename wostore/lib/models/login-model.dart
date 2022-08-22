import 'dart:convert';

Login loginFromMap(String str) => Login.fromMap(json.decode(str));

String loginToMap(Login data) => json.encode(data.toMap());

class Login {
    Login({
        this.address,
        this.city,
        this.country,
        this.email,
        this.fullName,
        this.gender,
        this.locality,
        this.mobileNumber,
        this.pincode,
        this.state,
        this.id,
        this.billingAddresses,
    });

    String address;
    String city;
    String country;
    String email;
    String fullName;
    String gender;
    String locality;
    String mobileNumber;
    String pincode;
    String state;
    int id;
    List<BillingAddress> billingAddresses;

    factory Login.fromMap(Map<String, dynamic> json) => Login(
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        email: json["email"] == null ? null : json["email"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        gender: json["gender"] == null ? null : json["gender"],
        locality: json["locality"] == null ? null : json["locality"],
        mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        state: json["state"] == null ? null : json["state"],
        id: json["id"] == null ? null : json["id"],
        billingAddresses: json["billing_addresses"] == null ? null : List<BillingAddress>.from(json["billing_addresses"].map((x) => BillingAddress.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "email": email == null ? null : email,
        "full_name": fullName == null ? null : fullName,
        "gender": gender == null ? null : gender,
        "locality": locality == null ? null : locality,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "pincode": pincode == null ? null : pincode,
        "state": state == null ? null : state,
        "id": id == null ? null : id,
        "billing_addresses": billingAddresses == null ? null : List<dynamic>.from(billingAddresses.map((x) => x.toMap())),
    };
}

class BillingAddress {
    BillingAddress({
        this.billingAddressName,
        this.address,
        this.city,
        this.state,
        this.mobileNumber,
        this.pincode,
        this.id,
        this.country,
    });

    String billingAddressName;
    String address;
    String city;
    String state;
    String mobileNumber;
    String pincode;
    int id;
    String country;

    factory BillingAddress.fromMap(Map<String, dynamic> json) => BillingAddress(
        billingAddressName: json["billing_address_name"] == null ? null : json["billing_address_name"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        id: json["id"] == null ? null : json["id"],
        country: json["country"] == null ? null : json["country"],
    );

    Map<String, dynamic> toMap() => {
        "billing_address_name": billingAddressName == null ? null : billingAddressName,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "pincode": pincode == null ? null : pincode,
        "id": id == null ? null : id,
        "country": country == null ? null : country,
    };
}
