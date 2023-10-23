import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CategoriesSmallCard extends StatelessWidget {
  final String? title;
  final int? tasksNum;
  final String? image;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final Function? onTap;
  const CategoriesSmallCard(
      {Key? key,
      this.title,
      this.gradientStartColor,
      this.gradientEndColor,
      this.onTap,
      this.tasksNum,
      this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            gradientStartColor ?? ColorsTheme.redColor1,
            gradientEndColor ?? ColorsTheme.blackColor2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Stack(
        children: [
          customSizeBox(
            height: 125,
            width: 150,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 125,
              width: 150,
              child: Stack(
                children: [
                  svgAsset(
                    color: Colors.transparent.withOpacity(0.1),
                    assetName:
                        IconsAssets().assets[IconName.soundgraphic].toString(),
                    height: 125.0,
                    width: 150.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 125,
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      image.toString(),
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "$tasksNum Tasks",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
