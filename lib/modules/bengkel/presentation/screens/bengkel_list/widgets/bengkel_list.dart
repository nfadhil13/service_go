part of '../bengkel_list_screen.dart';

class _BengkelListBottomSheet extends StatefulWidget {
  const _BengkelListBottomSheet({super.key});

  @override
  State<_BengkelListBottomSheet> createState() =>
      _BengkelListBottomSheetState();
}

class _BengkelListBottomSheetState extends State<_BengkelListBottomSheet> {
  final _sheetController = DraggableScrollableController();

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
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
        child: _BengkelList(scrollController, _sheetController),
      ),
    );
  }
}

class _BengkelList extends StatelessWidget {
  final ScrollController controller;
  final DraggableScrollableController sheetController;
  const _BengkelList(this.controller, this.sheetController);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BengkelListScreenCubit, BengkelListScreenCubitState>(
      listener: (context, state) {
        sheetController.jumpTo(.5);
        controller.jumpTo(0);
      },
      builder: (context, state) {
        final selected = state.selectedBengkel;
        return SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selected == null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.h),
                  child: Stack(
                    children: [
                      Text(
                        "Bengkel Terdekat",
                        style: context.text.labelSmall?.copyWith(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              if (selected != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.h),
                  child: _SelectedBengkel(selected: selected),
                ),
              if (selected != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(
                    top: 4.5.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bengkel Terdekat Lainya",
                        style: context.text.labelSmall?.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: context.color.outline,
                      ),
                    ],
                  ),
                ),
              1.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView.builder(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  key: Key(state.bengkelList[index].data.id),
                                  bengkelProfile: state.bengkelList[index])),
                        )),
              ),
            ],
          ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () => context.read<BengkelListScreenCubit>().clear(),
                child: const Icon(Icons.arrow_back_ios)),
            2.w.horizontalSpace,
            Text(
              selected.data.nama,
              style: context.text.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          children: [
            InkWell(
              onTap: () => SGImagePreview.asFullScreenDialog(
                  context, selected.data.profile),
              child: Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: selected.data.profile.provider)),
              ),
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
                  onTap: () => SGIntents.navigateFromTo(
                      start: context.currentLocation.latLgn,
                      end: bengkel.lokasi,
                      endTitle: bengkel.nama,
                      startTitle: context.currentLocation.shortAddress),
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
          onPressed: () {
            context.router.push(CustomerServisFormRoute(
                mode: CustomerServisFormCreate.byId(
                    bengkelId: selected.data.id)));
          },
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
