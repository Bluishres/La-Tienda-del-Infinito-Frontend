import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopend/app/common/utils/CustomPreferredSize.dart';
import 'package:shopend/app/common/utils/size_config.dart';

class CustomAppBar extends CustomPreferredSize {
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(7, context: context),
            horizontal: getProportionateScreenWidth(20, context: context)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40, context: context),
              width: getProportionateScreenWidth(40, context: context),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/logos/Back_ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
