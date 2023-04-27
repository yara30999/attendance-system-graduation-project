import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.searchQuery,
      required this.hintText,
      required this.onSearchTextChanged,
      required this.onSearchClearPressed,
      required this.searchController,
      required this.side,
      required this.height,
      this.box
      });

  final String searchQuery;
  final String hintText;
  final ValueChanged<String> onSearchTextChanged;
  final VoidCallback onSearchClearPressed;
  final TextEditingController searchController;
  final BorderSide side;
  final double? height;
  final Widget? box;
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        SizedBox(
          height: height,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Color(0xff074e79),
                  fontSize: 14.0,
                  fontFamily: 'poppins'),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onSearchClearPressed,
                    )
                  : null,
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  borderSide: side),
            ),
            controller: searchController,
            onChanged: onSearchTextChanged,
          ),
        ),
        Visibility(
          visible: searchQuery
              .isNotEmpty, // Boolean value indicating whether the widget should be visible or not
          child: Container(child: box,),
        )
        
      ],
    );
  }
}
