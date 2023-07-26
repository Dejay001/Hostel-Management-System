import 'package:flutter/material.dart';
import 'package:hostelmanagement/pages/filterpage.dart';

class FilterButton extends StatelessWidget {
  final Function(String location) onFilter;

  const FilterButton({required this.onFilter});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
      onPressed: () async {
        // Show the filter page and wait for the result
        final selectedLocation = await Navigator.of(context).push<String>(
          MaterialPageRoute(
            builder: (context) => FilterPage(), // Replace with your filter page
          ),
        );

        // If the selected location is not null, call the onFilter callback
        if (selectedLocation != null) {
          onFilter(selectedLocation);
        }
      },
    );
  }
}
