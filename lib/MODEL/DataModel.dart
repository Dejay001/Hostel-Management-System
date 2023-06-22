class Property {
  String label;
  String name;
  String price;
  String location;
  String sqm;
  String review;
  String description;
  String frontImage;
  String ownerImage;
  List<dynamic> images;

  //final allProperties = <Property> [

  Property(
    {required this.label,
    required this.name,
    required this.price,
    required this.location,
    required this.sqm,
    required this.review,
    required this.description,
    required this.frontImage,
    required this.ownerImage,
    required this.images});   
factory Property.fromJson( json) {
    return Property(
        label: json['label'] as String, name: json['name'] as String, price: json['price'], location:json['location'], description: json['description'], frontImage: json['frontImage'], images: json['images'] as List<dynamic>, ownerImage: json['ownerImage'], review: json['review'], sqm: json['sqm']);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'label': this.label, 'name': this.name, 'price': this.price, 'location': this.location, 'frontImage': this.frontImage, 'description':this.description,'review':this.review, 'sqm':this.sqm,'images':this.images,'ownerImage':this.ownerImage};
}

  



