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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selected.data.nama,
                      style: context.text.titleLarge,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 25.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: selected.data.profile.provider)),
                        )
                      ],
                    )
                  ],
                ),
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
                              bengkelProfile: state.bengkelList[index])),
                    )),
          ],
        );
      },
    );
  }
}
