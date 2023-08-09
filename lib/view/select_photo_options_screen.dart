import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app_localizations.dart';
import '../utils/widgets/select_photo_button.dart';

class SelectPhotoOptionsScreen extends StatelessWidget {
  final Function(ImageSource source) onTap;

  const SelectPhotoOptionsScreen({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            SelectPhotoButton(
              onTap: () => onTap(ImageSource.gallery),
              icon: Icons.image_outlined,
              textLabel:
                  AppLocalizations.of(context).translate('browse_gallery'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context).translate('or'),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SelectPhotoButton(
              onTap: () => onTap(ImageSource.camera),
              icon: Icons.camera_alt_outlined,
              textLabel: AppLocalizations.of(context).translate('use_a_camera'),
            ),
          ])
        ],
      ),
    );
  }
}
