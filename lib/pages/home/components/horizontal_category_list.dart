import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/get_news/get_new_bloc.dart';
import '../../../bloc/get_news/get_new_event.dart';

class HorizontalCategoryList extends StatefulWidget {
  const HorizontalCategoryList({Key? key}) : super(key: key);

  @override
  State<HorizontalCategoryList> createState() => _HorizontalCategoryListState();
}

class _HorizontalCategoryListState extends State<HorizontalCategoryList> {
  int selectedCategoryIndex =
      6; // Initialize with the first category as selected

  final List<String> items = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    // "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryWidget(
            categoryName: items[index],
            isSelected: index == selectedCategoryIndex,
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
              context
                  .read<GetNewsBloc>()
                  .add(ChangeNewsTypeEvent(items[index].toLowerCase()));
            },
          );
        },
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xfff1f1f1)),
            borderRadius: BorderRadius.circular(72),
            color: isSelected ? Colors.grey : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Center(
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: Color(0xff1a434e),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
