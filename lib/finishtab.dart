import 'package:flutter/material.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_loading.dart';

class FinishTab extends StatefulWidget {
  const FinishTab({
    Key? key,
    this.onSavePressed,
    this.onUploadToGoogle,
    this.googleUploadStatus = 0,
  }) : super(key: key);

  final ValueChanged<bool>? onSavePressed;
  final ValueChanged<bool>? onUploadToGoogle;
  final int googleUploadStatus;

  @override
  _FinishTabState createState() => _FinishTabState();
}

TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

class _FinishTabState extends State<FinishTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 500) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      });
    }
    if (width < 393) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
      });
    }
    if (width >= 600) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
      });
    }

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  HeadingMain(
                      styleFontSize: styleTitleTextTheme!.fontSize!,
                      backGroundColor: Theme.of(context).primaryColor,
                      headingText: "Save"),
                  ElevatedButton(
                      onPressed: () {
                        widget.onSavePressed!(true);
                      },
                      child: Text(
                        "Save to local Database",
                        style: styleBodyTextTheme,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            widget.onUploadToGoogle!(true);
                          },
                          child: Text(
                            "Save and Upload to Google Drive",
                            style: styleBodyTextTheme,
                          )),
                      LoadingImage(
                        state: widget.googleUploadStatus,
                        text: "",
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
