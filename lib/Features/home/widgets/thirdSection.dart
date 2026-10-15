import 'package:flutter/material.dart';
import 'package:shamedan/core/utils/Appfonts.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/core/widgets/primarybutton.dart';

class ThirdSection extends StatefulWidget {
  const ThirdSection({super.key});

  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(

        children: [
          const SizedBox(height: 36),
          Text(
            "معاك في كل وقت",
            style: AppFonts.titleLalezar.copyWith(
              color: AppColor.backgroundBlack,
            ),
          ),
             Row(
              children: [
                Image.asset(
                  'assets/images/product 1.png',
                  fit: BoxFit.contain,
                  width: 119,
                  height: 207,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "عملنا بسكوت سادة لوقت العصاري",
                        style: AppFonts.regularLemonade,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 26) ,
                      Text(
                        "بسكاوي عارف كويس ازاي يظبط الشاي جربه وعمرك ما هتندم .",
                        style: AppFonts.regularCairo,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 26) ,
                      PrimaryButton() ,
                      SizedBox(height: 26)
                    ],
                  ),
                ),

              ],
            ),
        ],
      ),
    );
  }
}