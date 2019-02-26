import 'package:flutter/material.dart';
import 'package:learn_web/color.dart';


//TitleBar start
class TitleBar extends StatelessWidget {

  final int bgColor;
  final String title;

  final GestureTapCallback onBack;
  final TitleBarRight right;

  TitleBar({
    this.bgColor,
    this.title,
    this.onBack,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    int bgColor = this.bgColor ?? whiteColor;
    String title = this.title ?? "";

    if (title.length > 8) {
      title = title.substring(0, 8) + "...";
    }
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 45,
                color: Color(bgColor),
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Text(title,
                          style: TextStyle(
                              fontSize: 17, color: Color(textColor1)),
                          maxLines: 1,
                        )
                    ),
                    backWidget,
                    rightWidget,
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          color: Color(dividerColor),
          height: 0.5,
        )
      ],
    );
  }

  Widget get backWidget {
    return GestureDetector(
        onTap: this.onBack,
        child: Offstage(
          offstage: this.onBack == null,
          child: Container(
              height: 45,
              padding: EdgeInsets.only(left: 15, right: 10),
              child: SizedBox.fromSize(
                size: Size(23, 23),
                child: Image.asset("assets/ic_back.png"),
              )
          ),
        )
    );
  }

  Widget get rightWidget {
    return GestureDetector(
      onTap: this.right.onClickRight,
      child: Offstage(
        offstage: this.right == null || this.right.onClickRight == null,
        child: Align(
          alignment: Alignment.centerRight,
          child: this.right.rightIcon != null ?
          Container(
              height: 45,
              width: 40,
              alignment: Alignment.center,
              child: SizedBox(
                width: 23,
                height: 23,
                child: Image.asset(this.right.rightIcon),
              )
          ) : Container(
              height: 45,
              width: 40,
              alignment: Alignment.center,
              child: Text(
                this.right.rightTitle != null ? this.right.rightTitle : "更多",
                style: TextStyle(fontSize: 14, color: Color(textColor1)),)
          ),
        ),
      ),
    );
  }
}

class TitleBarRight {
  String rightTitle;
  String rightIcon;
  GestureTapCallback onClickRight;


  TitleBarRight({
    this.rightTitle,
    this.rightIcon,
    this.onClickRight,
  });
}
//TitleBar end