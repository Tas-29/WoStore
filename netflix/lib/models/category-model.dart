class Category {
    Category({
        this.id,
        this.name,
        this.categoryImage,
        this.isActive,
    });

    int id;
    String name;
    String categoryImage;
    bool isActive;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        categoryImage: json["category_image"] == null ? null : json["category_image"],
        isActive: json["is_active"] == null ? null : json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "category_image": categoryImage == null ? null : categoryImage,
        "is_active": isActive == null ? null : isActive,
    };
}