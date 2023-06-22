import 'package:flutter/material.dart';
import 'package:hostelmanagement/data/data_home.dart';
import 'package:hostelmanagement/pages/saved.dart';
import 'package:hostelmanagement/pages/search.dart';

import 'homepage.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 45, 0, 10),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) {
                return CategorysWidget(categoryList[position]);
              },
              itemCount: categoryList.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
          BottomBarWidget(),
        ],
      ),
    );
  }
}

class CategorysWidget extends StatelessWidget {
  final Category category;

  CategorysWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(category.image),
                  opacity: 0.85
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              )),
        ),
        Positioned(
          left: 35,
          bottom: 20,
          child: Text(
            category.name,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  Color selectedColor = homepage.themeColor;
  Color unSelectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        height: 60.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            color: Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => homepage(),
                ),
              ),
            },
            child: Column(
              children: [
                Icon(Icons.home,
                    color:
                        _selectedIndex == 3 ? selectedColor : unSelectedColor),
                Text("Home",
                    style: TextStyle(
                        color: _selectedIndex == 3
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            child: Column(
              children: [
                Icon(Icons.search,
                    color:
                        _selectedIndex == 1 ? selectedColor : unSelectedColor),
                Text("Search",
                    style: TextStyle(
                        color: _selectedIndex == 1
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _showBottomSheet();
            },
            child: Column(
              children: [
                Icon(Icons.favorite_border,
                    color:
                        _selectedIndex == 2 ? selectedColor : unSelectedColor),
                Text("Saved",
                    style: TextStyle(
                        color: _selectedIndex == 2
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _onTap(0);
            },
            child: Column(
              children: [
                Icon(Icons.category_outlined,
                    color:
                        _selectedIndex == 0 ? selectedColor : unSelectedColor),
                Text("Category",
                    style: TextStyle(
                        color: _selectedIndex == 0
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
        ]));
  }

  void _onTap(int tapIndex) {
    setState(() {
      _selectedIndex = tapIndex;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Saved(),
            ],
          );
        });
  }
}
