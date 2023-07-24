part of '../bengkel_list_screen.dart';

class _BengkelListBottomSheet extends StatelessWidget {
  const _BengkelListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: .4,
      initialChildSize: .4,
      maxChildSize: .9,
      builder: (context, scrollController) => SGBottomSheetContainer(
        shadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          )
        ],
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [15.verticalSpace, const _BengkelList()],
          ),
        ),
      ),
    );
  }
}

class _BengkelList extends StatelessWidget {
  const _BengkelList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BengkelListScreenCubit, BengkelListScreenCubitState>(
      builder: (context, state) {
        final selected = state.selectedBengkel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selected == null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  "Bengkel Terdekat",
                  style: context.text.labelSmall
                      ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
            if (selected != null)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 2.h),
                child: _SelectedBengkel(selected: selected),
              ),
            if (selected != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(
                  top: 4.h,
                ),
                child: Text(
                  "Bengkel Terdekat Lainya",
                  style: context.text.labelSmall
                      ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ListView.builder(
                itemCount: state.bengkelList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                          onTap: () {
                            context
                                .read<BengkelListScreenCubit>()
                                .selectBengkel(state.bengkelList[index]);
                          },
                          child: BengkelProfileWidget(
                              key: Key(state.bengkelList[index].data.id),
                              bengkelProfile: state.bengkelList[index])),
                    )),
          ],
        );
      },
    );
  }
}

class _SelectedBengkel extends StatelessWidget {
  const _SelectedBengkel({
    required this.selected,
  });

  final BengkelProfileWithDistance selected;

  @override
  Widget build(BuildContext context) {
    final bengkel = selected.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selected.data.nama,
          style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        12.verticalSpace,
        Row(
          children: [
            Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: selected.data.profile.provider)),
            ),
            16.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alamat",
                    style: context.text.bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  "${bengkel.alamat.shortAddress}, ${bengkel.alamat.subAdministrativeArea}",
                  style: context.text.bodySmall,
                ),
                12.verticalSpace,
                InkWell(
                  onTap: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    final location = bengkel.lokasi;
                    await availableMaps.first.showMarker(
                      coords: Coords(
                        location.lat,
                        location.long,
                      ),
                      title: bengkel.nama,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.navigation_rounded,
                        color: context.color.primary,
                      ),
                      5.horizontalSpace,
                      Text(
                        "Arahkan ke bengkel",
                        style: context.text.bodySmall
                            ?.copyWith(color: context.color.primary),
                      ),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
        16.verticalSpace,
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Layanan Bengkel",
              style: context.text.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold, color: context.color.onSurface),
            )),
        12.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: Wrap(runSpacing: 8, spacing: 8, children: [
            ...bengkel.jenisLayanan.take(3).map((e) => Container(
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
                )),
            if (bengkel.jenisLayanan.length > 3)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.color.primary),
                child: Text(
                  "${bengkel.jenisLayanan.length - 3} Layanan Lainya",
                  style: context.text.labelSmall
                      ?.copyWith(color: context.color.onPrimary),
                ),
              )
          ]),
        ),
        14.verticalSpace,
        SGElevatedButton(
          padding: const EdgeInsets.symmetric(vertical: 0),
          label: "Pesan",
          buttonIconType: ButtonIconType.far,
          textStyle:
              context.text.bodyMedium?.copyWith(color: context.color.onPrimary),
          onPressed: () {},
          fillParent: true,
        ),
        5.verticalSpace,
        SGOutlinedButton(
          padding: const EdgeInsets.symmetric(vertical: 0),
          label: "Lihat Detail Bengkel",
          textStyle:
              context.text.bodyMedium?.copyWith(color: context.color.primary),
          onPressed: () {},
          fillParent: true,
          suffixIcon: const Icon(
            Icons.arrow_forward_ios,
            size: 12,
          ),
        )
      ],
    );
  }
}
