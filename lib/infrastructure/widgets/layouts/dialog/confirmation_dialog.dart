part of 'dialog_container.dart';

class SGConfirmationDialog extends StatelessWidget {
  final Future<void> Function(Future<void> Function() closeDialog)? onConfirm;

  final Future<void> Function(Future<void> Function() closeDialog)? onCancel;
  final double? maxHeightPercentage;
  final String? title;
  final String? desc;
  final Widget? descWidget;
  final Widget? extraInfo;

  const SGConfirmationDialog._(
      {required this.onConfirm,
      this.title,
      this.desc,
      this.extraInfo,
      this.onCancel,
      this.descWidget,
      this.maxHeightPercentage});

  static Future<T?> launch<T>(BuildContext context,
      {Future<void> Function(Future<void> Function() closeDialog)? onConfirm,
      double? maxHeightPercentage,
      String? title,
      Widget? descWidget,
      Future<void> Function(Future<void> Function() closeDialog)? onCancel,
      String? desc}) async {
    return showDialog(
        context: context,
        builder: (context) => SGConfirmationDialog._(
              onConfirm: onConfirm,
              maxHeightPercentage: maxHeightPercentage,
              desc: desc,
              onCancel: onCancel,
              descWidget: descWidget,
              title: title,
            ));
  }

  static Future<bool> launchAsync<T>(BuildContext context,
      {double? maxHeightPercentage,
      String? title,
      Widget? descWidget,
      Widget? extraInfo,
      String? desc}) async {
    final result = await showDialog(
        context: context,
        builder: (context) => SGConfirmationDialog._(
              onConfirm: (closeDialog) {
                return context.router.pop(true);
              },
              maxHeightPercentage: maxHeightPercentage,
              desc: desc,
              extraInfo: extraInfo,
              onCancel: (closeDialog) {
                return context.router.pop(false);
              },
              descWidget: descWidget,
              title: title,
            ));
    return result is bool && result == true;
  }

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
                if (descWidget != null) descWidget!,
                if (desc != null && descWidget == null)
                  Text(
                    desc!,
                    textAlign: TextAlign.start,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.color.onSurfaceVariant),
                  ),
                if (extraInfo != null) extraInfo!,
                12.verticalSpace,
                Column(
                  children: [
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            final onCancel = this.onCancel;
                            if (onCancel == null) {
                              context.router.root.pop();
                              return;
                            }
                            onCancel(context.router.pop);
                          },
                          child: Text(
                            "Batal",
                            style: context.text.labelLarge
                                ?.copyWith(color: context.color.primary),
                          ),
                        ),
                        12.horizontalSpace,
                        InkWell(
                          onTap: () {
                            final onConfirm = this.onConfirm;
                            if (onConfirm == null) {
                              context.router.root.pop();
                              return;
                            }
                            onConfirm(context.router.pop);
                          },
                          child: Text(
                            "Konfirmasi",
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
