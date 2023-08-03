import 'package:flutter/material.dart';
import 'package:learn_bloc_2/pages/widgets/spacer_custom.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.textEditingController,
    required this.onTap,
  });
  final TextEditingController textEditingController;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 204, 204, 204),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your value';
                  }
                  return null;
                },
                onEditingComplete: onTap,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Search...', border: InputBorder.none),
              ),
            ),
            const CustomWidthSpacer(
              size: 0.03,
            ),
            InkWell(
              onTap: onTap,
              child: Image.asset(
                Assets.icons.icUnselectedSearchNormal.path,
                width: 24,
                height: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
