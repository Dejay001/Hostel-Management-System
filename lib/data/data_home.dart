class Category {
  String image;
  String name;

  Category(this.name, this.image);
}

List<Category> categoryList = [
  Category("Residential","assets/images/Residential.jpg"),
  Category("Commercial","assets/images/commercial.jpg"),
  Category("Agricultural", "assets/images/land.jpg"),
  Category("Industrial", "assets/images/industrial.jpg"),
  Category("Mixed-Use", "assets/images/mixeduse.jpg"),
  Category("Special Purpose", "assets/images/specialpurpose.jpg"),
];

List<String> nearbyList = [
  "assets/images/house_03.jpg",
  "assets/images/house_06.jpg",
  "assets/images/house_08.jpg"
];

List<String> exploreList = [
  "assets/images/house_02.jpg",
  "assets/images/house_04.jpg",
  "assets/images/house_05.jpg"
];
