import 'package:flutter/material.dart';
import 'package:shamedan/Features/home/widgets/fifth_section/beginning_section.dart';
import 'package:shamedan/Features/home/widgets/fifth_section/footer_section.dart';
import 'package:shamedan/Features/home/widgets/fifth_section/history_dome_section.dart';
import 'package:shamedan/Features/home/widgets/fifth_section/product_showcase_section.dart';

class FifthSection extends StatelessWidget {
  const FifthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HistoryDomeSection(),
        SizedBox(height: 36),
        BeginningSection(),
        SizedBox(height: 32),
        ProductShowcaseSection(),
        SizedBox(height: 48),
        FooterSection(),
      ],
    );
  }
}
