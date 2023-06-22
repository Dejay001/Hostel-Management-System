class addedProduct {
  addedProduct({
    this.name,
    this.cost,
    this.group,
    this.location,
    this.company,
    this.quantity,
    this.image,
    this.description,
  });

  String? name;
  String? cost;
  String? group;
  String? location;
  String? company;
  int? quantity;
  String? image;
  String? description;

  factory addedProduct.fromMap(Map<String, dynamic> json) => addedProduct(
    name: json["name"] as String?,
    cost: json["cost"] as String?,
    group: json["group"] as String?,
    location: json["location"] as String?,
    company: json["company"] as String?,
    quantity: json["quantity"] as int?,
    image: json["image"] as String?,
    description: json["description"] as String?,
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "cost": cost,
    "group": group,
    "location": location,
    "company": company,
    "quantity": quantity,
    "image": image,
    "description": description,
  };
}
