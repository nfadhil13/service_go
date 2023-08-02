part of 'dialog_container.dart';

class SGActionDialog<T> extends StatelessWidget {
  final void Function()? onSubmit;
  final Widget action;
  final String? confirmText;
  final String? cancelText;
  final double? maxHeightPercentage;
  final String? desc;
  final String? title;

  const SGActionDialog(
      {this.onSubmit,
      this.title,
      this.maxHeightPercentage,
      this.confirmText,
      this.cancelText,
      required this.action,
      this.desc});

  // static Future<T?> launchAsync<T>(BuildContext context,
  //     {required void Function()? onSubmit,
  //     required Widget action,
  //     String? confirmText,
  //     String? cancelText,
  //     double? maxHeightPercentage,
  //     String? title,
  //     String? desc}) async {
  //   final result = await showDialog(
  //       context: context,
  //       builder: (context) => SGActionDialog._(
  //             onSubmit: onSubmit,
  //             action: action,
  //             desc: desc,
  //             confirmText: confirmText,
  //             cancelText: cancelText,
  //             maxHeightPercentage: maxHeightPercentage,
  //             title: title,
  //           ));
  //   if (result is T) return result;
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return SGDialogContainer(
        maxHeightPercentage: maxHeightPercentage ?? .5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: context.text.headlineSmall,
                  ),
                const SizedBox(height: 5),
                if (desc != null)
                  Text(
                    desc!,
                    textAlign: TextAlign.start,
                    style: context.text.bodySmall
                        ?.copyWith(color: context.color.onSurfaceVariant),
                  ),
                action,
                12.verticalSpace,
                Column(
                  children: [
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            context.router.root.pop();
                          },
                          child: Text(
                            cancelText ?? "Batal",
                            style: context.text.labelLarge
                                ?.copyWith(color: context.color.primary),
                          ),
                        ),
                        12.horizontalSpace,
                        InkWell(
                          onTap: onSubmit,
                          child: Text(
                            confirmText ?? "Konfirmasi",
                            style: context.text.labelLarge
                                ?.copyWith(color: context.color.primary),
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
