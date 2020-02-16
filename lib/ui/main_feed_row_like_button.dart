import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> {
  String unselectedUrl = "assets/images/like.svg";
  String selectedUrl = "assets/images/heart_filled.svg";
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: SvgPicture.asset(
        isSelected ? selectedUrl : unselectedUrl,
        width: 24.0,
        height: 24.0,
      ),
    );
  }
}
