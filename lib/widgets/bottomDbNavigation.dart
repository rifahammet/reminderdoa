import 'package:flutter/material.dart';
import 'package:doa/widgets/nav_bar_item_widget.dart';


class BottomDbNavigationBarApp extends StatelessWidget {
  final int BottomNavigationBarIndex;
  final BuildContext context;
  final callBack;

  const BottomDbNavigationBarApp(
      this.context, this.BottomNavigationBarIndex, this.callBack);

  void onTabTapped(int index) {
    return callBack(index);
    // Navigator.of(context).push(
    //   MaterialPageRoute<Null>(builder: (BuildContext context) {
    //     return (index == 1) ? Task() : Home();
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 2,
      child: 
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                onTabTapped(0);
              },
              iconData: 'assets/images/left.png',
              text: 'First',
              color: BottomNavigationBarIndex == 0
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                onTabTapped(1);
              },
              iconData: 'assets/images/left-arrow.png',
              text: 'Previous',
              color: BottomNavigationBarIndex == 1
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                onTabTapped(2);
              },
              iconData: 'assets/images/right-arrow.png',
              text: 'Next',
              color: BottomNavigationBarIndex == 2
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                onTabTapped(3);
              },
              iconData: 'assets/images/right.png',
              text: 'Last',
              color: BottomNavigationBarIndex == 3
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
