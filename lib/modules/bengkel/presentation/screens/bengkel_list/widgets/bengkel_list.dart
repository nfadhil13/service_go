part of '../bengkel_list_screen.dart';

class _BengkelList extends StatelessWidget {
  const _BengkelList({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: .4,
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
            children: [
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  "Bengkel Terdekat",
                  style: context.text.labelSmall
                      ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
              15.verticalSpace,
              BengkelListWidget(cubit: context.read<BengkelListCubit>()),
            ],
          ),
        ),
      ),
    );
  }
}
