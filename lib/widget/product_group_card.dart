
import 'package:flutter/material.dart';
import 'package:hostelmanagement/pages/product_group_page.dart';

import '../utils/color_palette.dart';

class ProductGroupCard extends StatelessWidget {
  final String? name;

  const ProductGroupCard({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ProductGroupPage(
                  name: name,
                );
              },
            ),
          );
        },
        child: Container(


          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.16),
              ),
            ],
          ),
          child: Text(
            name!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Nunito",
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // TODO: Add counter
        ),
      ),
    );
  }
}
