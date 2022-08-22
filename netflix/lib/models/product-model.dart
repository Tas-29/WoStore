import 'package:netflix/models/category-model.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.attributes,
    this.variantMapping,
    this.seller,
    this.category,
    this.description,
    this.variant,
    this.quantity = 1,
  });

  int id;
  String name;
  List<dynamic> attributes;
  List<String> variantMapping;
  Seller seller;
  Category category;
  Description description;
  List<Variant> variant;
  int quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        attributes: json["attributes"] == null
            ? null
            : List<dynamic>.from(json["attributes"].map((x) => x)),
        variantMapping: json["variantMapping"] == null
            ? null
            : List<String>.from(json["variantMapping"].map((x) => x)),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        variant: json["variant"] == null
            ? null
            : List<Variant>.from(
                json["variant"].map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes.map((x) => x)),
        "variantMapping": variantMapping == null
            ? null
            : List<dynamic>.from(variantMapping.map((x) => x)),
        "seller": seller == null ? null : seller.toJson(),
        "category": category == null ? null : category.toJson(),
        "description": description == null ? null : description.toJson(),
        "variant": variant == null
            ? null
            : List<dynamic>.from(variant.map((x) => x.toJson())),
      };
}

class Description {
  Description({
    this.id,
    this.language,
    this.value,
  });

  int id;
  String language;
  String value;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        id: json["id"] == null ? null : json["id"],
        language: json["language"] == null ? null : json["language"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "language": language == null ? null : language,
        "value": value == null ? null : value,
      };
}

class Seller {
  Seller({
    this.id,
    this.companyName,
    this.ownerName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pincode,
    this.country,
    this.phone,
    this.email,
    this.password,
    this.logoLink,
  });

  int id;
  String companyName;
  String ownerName;
  String address1;
  String address2;
  String city;
  String state;
  String pincode;
  String country;
  String phone;
  String email;
  String password;
  String logoLink;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"] == null ? null : json["id"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        country: json["country"] == null ? null : json["country"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        logoLink: json["logo_link"] == null ? null : json["logo_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_name": companyName == null ? null : companyName,
        "owner_name": ownerName == null ? null : ownerName,
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pincode": pincode == null ? null : pincode,
        "country": country == null ? null : country,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "logo_link": logoLink == null ? null : logoLink,
      };
}

class Variant {
  Variant({
    this.id,
    this.imageLinks,
    this.attributes,
    this.isActive,
    this.price,
  });

  int id;
  List<String> imageLinks;
  List<String> attributes;
  bool isActive;
  Price price;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"] == null ? null : json["id"],
        imageLinks: json["image_links"] == null
            ? null
            : List<String>.from(json["image_links"].map((x) => x)),
        attributes: json["attributes"] == null
            ? null
            : List<String>.from(json["attributes"].map((x) => x)),
        isActive: json["is_active"] == null ? null : json["is_active"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image_links": imageLinks == null
            ? null
            : List<dynamic>.from(imageLinks.map((x) => x)),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes.map((x) => x)),
        "is_active": isActive == null ? null : isActive,
        "price": price == null ? null : price.toJson(),
      };
}

class Price {
  Price({
    this.id,
    this.retailPrice,
    this.salePrice,
  });

  int id;
  int retailPrice;
  int salePrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"] == null ? null : json["id"],
        retailPrice: json["retail_price"] == null ? null : json["retail_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "retail_price": retailPrice == null ? null : retailPrice,
        "sale_price": salePrice == null ? null : salePrice,
      };
}
