import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';

enum ImageCarouselType { network, file, assets, memory }

class ImageCarouselData {
  final ImageProvider provider;
  final bool disableGesture;

  ImageCarouselData({required this.provider, this.disableGesture = false});
}

enum ImagesCarouselScale {
  covered(PhotoViewComputedScale.covered),
  contained(PhotoViewComputedScale.contained);

  final PhotoViewComputedScale scale;

  const ImagesCarouselScale(this.scale);
}

class ImagesCarousel extends StatefulWidget {
  final List<ImageCarouselData> imageList;
  final void Function(int index)? onIndexChange;
  final int startinIndex;
  final PageController controller;
  final ImagesCarouselScale scale;
  final bool showController;

  const ImagesCarousel(
      {Key? key,
      required this.imageList,
      this.startinIndex = 0,
      this.onIndexChange,
      this.showController = true,
      this.scale = ImagesCarouselScale.contained,
      required this.controller})
      : super(key: key);

  static showAsDialog(
    BuildContext context, {
    required List<ImageCarouselData> imageList,
    int startingIndex = 0,
    ImagesCarouselScale scale = ImagesCarouselScale.contained,
  }) {
    _showAsDialog(
        context,
        _ImageCarouselDialogWrapper(
            initialIndex: startingIndex,
            builder: (controller) {
              return ImagesCarousel(
                  imageList: imageList,
                  controller: controller,
                  scale: scale,
                  startinIndex: startingIndex);
            }));
  }

  static _showAsDialog(BuildContext context, Widget imageCarouselWithDots) {
    showDialog(
        barrierDismissible: true,
        context: context,
        barrierLabel: '',
        useSafeArea: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Material(
            color: Colors.black.withOpacity(0.5),
            elevation: 0,
            child: imageCarouselWithDots,
          );
        });
  }

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImageCarouselDialogWrapper extends StatefulWidget {
  final int initialIndex;
  final Widget Function(PageController controller) builder;
  const _ImageCarouselDialogWrapper(
      {super.key, required this.builder, required this.initialIndex});

  @override
  State<_ImageCarouselDialogWrapper> createState() =>
      _ImageCarouselDialogWrapperState();
}

class _ImageCarouselDialogWrapperState
    extends State<_ImageCarouselDialogWrapper> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller);
  }
}

class _ImagesCarouselState<T extends ImagesCarousel> extends State<T> {
  late PageController _pageController;
  late int _selectedImageIndex;

  @override
  void initState() {
    _pageController = widget.controller;
    _selectedImageIndex = widget.startinIndex;
    super.initState();
  }

  void _onPageChange(int index) {
    widget.onIndexChange?.call(index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void triggerCaraouselChange(int index) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoViewGallery.builder(
          pageController: _pageController,
          onPageChanged: (index) {
            if (widget.showController) {
              _selectedImageIndex = index;
              setState(() {});
            }
            widget.onIndexChange?.call(index);
          },
          itemCount: widget.imageList.length,
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          builder: (ctx, index) => PhotoViewGalleryPageOptions(
            minScale: widget.scale.scale,
            maxScale: widget.scale.scale,
            disableGestures: widget.imageList[index].disableGesture,
            imageProvider: widget.imageList[index].provider,
            heroAttributes: PhotoViewHeroAttributes(
              tag: index.toString(),
            ),
          ),
        ),
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
        if (widget.showController)
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imageList
                        .mapIndexed((i, e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImageIndex = i;
                                  });
                                  triggerCaraouselChange(i);
                                },
                                child: Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                      border: i == _selectedImageIndex
                                          ? Border.all(
                                              color: Colors.white,
                                              width: 2,
                                              style: BorderStyle.solid)
                                          : null,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: e.provider)),
                                  child: i != _selectedImageIndex
                                      ? null
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.black.withOpacity(.5),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                32.verticalSpace
              ],
            ),
          ),
      ],
    );
  }
}
