class Category {
  String image;
  String name;

  Category(this.name, this.image);
}

List<Category> categoryList = [
  Category("GCTU","assets/images/gctu.png"),
  Category("UG-LEGON","assets/images/ug.png"),
  Category("UPSA", "assets/images/UPSA.png"),
  Category("CENTRAL", "assets/images/central.png"),
  // Category("UCC", "assets/images/specialpurpose.jpg"),
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
