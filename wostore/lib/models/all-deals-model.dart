class Deals {
    Deals({
        this.id,
        this.name,
        this.imageLink,
    });

    int id;
    String name;
    String imageLink;

    factory Deals.fromJson(Map<String, dynamic> json) => Deals(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        imageLink: json["image_link"] == null ? null : json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image_link": imageLink == null ? null : imageLink,
    };
}
