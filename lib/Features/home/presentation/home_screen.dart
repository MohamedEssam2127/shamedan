import 'package:flutter/material.dart';
import 'package:shamedan/Features/home/widgets/FourthSection.dart';
import 'package:shamedan/Features/home/widgets/firstSection.dart';
import 'package:shamedan/Features/home/widgets/second_section.dart';
import 'package:shamedan/Features/home/widgets/thirdSection.dart';
import 'package:shamedan/core/utils/app_color.dart';

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
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo 1.png',
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              Firstsection(),
              SecondSection(),
              ThirdSection(),
              FourthSection(),
            ],
          ),
        ),
      ),
    );
  }
}
