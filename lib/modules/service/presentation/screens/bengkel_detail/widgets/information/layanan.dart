part of '../../servis_bengkel_detail_screen.dart';

class _Layanan extends StatelessWidget {
  final List<JenisLayanan> layananList;
  const _Layanan({super.key, required this.layananList});

  @override
  Widget build(BuildContext context) {
    return SGExpandableContainer(
      title: "Layanan yang dipilih",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.verticalSpace,
          Wrap(runSpacing: 12, children: [
            ...layananList.map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: context.color.primary),
                    child: Text(
                      e.name,
                      style: context.text.labelSmall
                          ?.copyWith(color: context.color.onPrimary),
                    ),
                  ),
                )),
          ]),
        ],
      ),
    );
  }
}
