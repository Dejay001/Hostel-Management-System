class Category {
  String image;
  String name;

  Category(this.name, this.image);
}

List<Category> categoryList = [
  Category("GCTU","assets/images/Residential.jpg"),
  Category("UG-LEGON","assets/images/commercial.jpg"),
  Category("UPSA", "assets/images/land.jpg"),
  Category("CENTRAL", "assets/images/mixeduse.jpg"),
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
