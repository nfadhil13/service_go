part of '../bengkel_profile_screen.dart';

class _SectionItem {
  final String title;
  final String? item;
  final Widget? widget;

  _SectionItem({required this.title, this.item, this.widget});
}

class _Section extends StatelessWidget {
  final String title;
  final String? actionName;
  final VoidCallback? actionOnTap;
  final List<_SectionItem> items;
  const _Section(
      {required this.title,
      required this.items,
      this.actionName,
      this.actionOnTap});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(title,
                    style: text.titleMedium?.copyWith(
                      color: color.onSurface,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              if (actionName != null)
                InkWell(
                  onTap: actionOnTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      actionName!,
                      style: text.titleSmall?.copyWith(color: color.primary),
                    ),
                  ),
                )
            ],
          ),
        ),
        6.verticalSpace,
        Divider(
          height: 2,
          color: color.outline,
        ),
        5.verticalSpace,
        ...items.map((e) {
          final title = e.title;
          final itemText = e.item;
          final widget = e.widget;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: text.titleSmall,
                ),
                2.verticalSpace,
                if (itemText != null && widget == null)
                  Text(
                    itemText,
                    style: text.bodyMedium?.copyWith(color: color.outline),
                  ),
                if (widget != null) widget,
              ],
            ),
          );
        })
      ],
    );
  }
}
