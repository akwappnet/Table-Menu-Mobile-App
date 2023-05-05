import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String? heading, title, descriptions, btn1Text, btn2Text;
  final Image? img;
  final Color? backgroundColor;
  final Icon? icon;

  final VoidCallback? onClicked;

  const CustomDialogBox(
      {Key? key,
        this.title,
        this.descriptions,
        this.heading,
        this.btn1Text,
        this.btn2Text,
        this.img,
        this.icon,
        this.backgroundColor,
        this.onClicked})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 20, top: 65, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.heading ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                widget.title ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                widget.descriptions!,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.btn1Text == ""
                      ? SizedBox()
                      : SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onClicked!();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          backgroundColor: widget.backgroundColor ??
                              Colors.red),
                      child: Text(
                        widget.btn1Text!,
                        style: TextStyle(
                            fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.btn1Text == ""
                      ? SizedBox()
                      : SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          backgroundColor: Colors.grey),
                      child: Text(
                        widget.btn2Text!,
                        style: TextStyle(
                            fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 47,
            child: CircleAvatar(
              backgroundColor:
              widget.backgroundColor ?? Colors.red,
              radius: 45,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: widget.icon ??
                    Icon(
                      Icons.delete_forever_rounded,
                      size: 50,
                    ),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}