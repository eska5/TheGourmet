import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/add_screen/sub_screens/load_image.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/load_image.dart';

import 'methods.dart';

class LoadImageDialog extends StatefulWidget {
  final Function onClick;
  final ImageSource imageSource1;
  final ImageSource imageSource2;
  final IconData iconData1;
  final IconData iconData2;
  final String text1;
  final String text2;
  final Offset menuOffset;
  final double menuWidth;
  final double menuHeight;
  final double menuOpacity;
  final Widget? menuInnerWidget;
  final bool isButton;
  final bool forClassification;

  const LoadImageDialog({
    Key? key,
    required this.imageSource1,
    required this.imageSource2,
    required this.iconData1,
    required this.iconData2,
    required this.text1,
    required this.text2,
    required this.menuOffset,
    required this.menuWidth,
    required this.menuHeight,
    required this.menuOpacity,
    this.menuInnerWidget,
    required this.onClick,
    required this.isButton,
    required this.forClassification,
  }) : super(key: key);

  @override
  State<LoadImageDialog> createState() => _LoadImageDialog();
}

class _LoadImageDialog extends State<LoadImageDialog> {
  void setPickedImage(BuildContext context, ImageSource source) async {
    if (widget.forClassification) {
      ClassifyLoadImageScreen.pickedImage =
          await pickImage(source, context, widget.forClassification);
    } else {
      AddLoadImageScreen.pickedImage =
          await pickImage(source, context, widget.forClassification);
    }
    setState(() {
      widget.onClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "Kliknij, żeby dodać zdjęcie",
      elevation: 100,
      offset: widget.menuOffset,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      color: Colors.deepPurpleAccent,
      initialValue: 1,
      child: Container(
        width: widget.menuWidth,
        height: widget.menuHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFFE9901).withOpacity(widget.menuOpacity),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          boxShadow: [
            widget.isButton == true
                ? const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    spreadRadius: 1,
                    offset: Offset(0, 0))
                : const BoxShadow(color: Colors.transparent)
          ],
        ),
        child: widget.menuInnerWidget,
      ),
      // ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          onTap: () => setPickedImage(
            context,
            widget.imageSource1,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData1,
                size: 28,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                widget.text1,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () => setPickedImage(context, widget.imageSource2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData2,
                size: 28,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                widget.text2,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
