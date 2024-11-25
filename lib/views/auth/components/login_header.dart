import 'package:flutter/material.dart';

import '../../../core/components/network_image copy.dart';

import '../../../core/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7, // Increased the width
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset('assets/JPEG-1222.jpg'), // Updated with your asset path
          ),
        ),
        Text(
          'Welcome to',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'CLASSWiX',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }
}
