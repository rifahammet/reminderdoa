import 'package:flutter/material.dart';

class NavBarItemWidget extends StatelessWidget {
  final dynamic onTap;
  final String? iconData;
  final String? text;
  final Color? color;

  const NavBarItemWidget({
    Key? key,
    @required this.onTap,
    @required this.iconData,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
                  iconData.toString(),
                  color: color,
                ),
            // Icon(
            //   iconData,
            //   color: color,
            // ),
            Text(
              text.toString(),
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w300,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
