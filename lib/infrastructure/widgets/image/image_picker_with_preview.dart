import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/form/image/image_picker.dart';
import 'package:service_go/infrastructure/widgets/image/image_carousel.dart';
import 'package:service_go/infrastructure/widgets/image/image_picker.dart';

class SGImagePickerWithPreview extends StatefulWidget {
  const SGImagePickerWithPreview._({super.key});

  static Future<List<XFile>> pickImages(BuildContext context) async {
    final result = await context.router.pushNativeRoute(MaterialPageRoute(
        builder: (context) => const SGImagePickerWithPreview._()));
    if (result is List<XFile>) return result;
    return [];
  }

  @override
  State<SGImagePickerWithPreview> createState() =>
      _SGImagePickerWithPreviewState();
}

class _SGImagePickerWithPreviewState extends State<SGImagePickerWithPreview> {
  final List<XFile> images = [];
  int? selectedImages;
  final pageController = PageController();
  final previewController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      pickImage();
    });
  }

  void pickImage() async {
    final image = await SGImagePickerDialog.pickImages(context);
    if (image.isEmpty) return;

    selectedImages = images.isEmpty ? 0 : images.length + 1;
    images.addAll(image);
    setState(() {});
    if (selectedImages == null) return;
    triggerCaraouselChange(selectedImages!);
  }

  void triggerCaraouselChange(int index) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ImagesCarousel(
              showController: false,
              controller: pageController,
              onIndexChange: (index) {
                setState(() {
                  selectedImages = index;
                });
              },
              imageList: images
                  .map((e) =>
                      ImageCarouselData(provider: FileImage(File(e.path))))
                  .toList()),
          Positioned(
              child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton.small(
                heroTag: null,
                onPressed: () {
                  context.router.pop();
                },
                child: const Icon(Icons.close),
              ),
            ),
          )),
          SizedBox.expand(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (images.length > 1)
                  SingleChildScrollView(
                    controller: previewController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images
                          .mapIndexed((i, e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImages = i;
                                    });
                                    triggerCaraouselChange(i);
                                  },
                                  child: Container(
                                    height: 84,
                                    width: 84,
                                    decoration: BoxDecoration(
                                        border: i == selectedImages
                                            ? Border.all(
                                                color: Colors.white,
                                                width: 2,
                                                style: BorderStyle.solid)
                                            : null,
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(e.path)))),
                                    child: i != selectedImages
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                images.removeAt(i);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black
                                                    .withOpacity(.5),
                                              ),
                                              child: const Icon(
                                                Icons.delete_outline,
                                                size: 48,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                32.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SGElevatedButton(
                      label: "Add More",
                      backgroundColor: Colors.grey.withOpacity(.4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 28),
                      onPressed: pickImage,
                      foregroundColor: Colors.white,
                    ),
                    const Expanded(child: SizedBox()),
                    FloatingActionButton(
                      onPressed: () {
                        context.router.pop(images);
                      },
                      backgroundColor: context.color.primary,
                      foregroundColor: context.color.onPrimary,
                      child: const Icon(Icons.send),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
