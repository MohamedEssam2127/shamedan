import 'package:flutter/material.dart';
import 'package:shamedan/Features/home/widgets/FifthSection.dart';
import 'package:shamedan/Features/home/widgets/FourthSection.dart';
import 'package:shamedan/Features/home/widgets/firstSection.dart';
import 'package:shamedan/Features/home/widgets/second_section.dart';
import 'package:shamedan/Features/home/widgets/thirdSection.dart';
import 'package:shamedan/core/utils/app_color.dart';
import 'package:shamedan/core/widgets/customAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.backGroundColor,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              Firstsection(),
              SecondSection(),
              ThirdSection(),
              FourthSection(),
              FifthSection(),
            ],
          ),
        ),
      ),
    );
  }
}
