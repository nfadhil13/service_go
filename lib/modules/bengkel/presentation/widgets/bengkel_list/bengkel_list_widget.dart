import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/loading/circular.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart';

class BengkelListWidget extends StatelessWidget {
  final SGDataQuery? query;
  final ScrollController? scrollController;
  final BengkelListCubit? cubit;
  const BengkelListWidget(
      {super.key, this.query, this.cubit, this.scrollController});
  @override
  Widget build(BuildContext context) {
    final cubit = this.cubit;
    return MultiBlocProvider(
      providers: [
        if (cubit == null)
          BlocProvider(
            create: (context) =>
                getIt<BengkelListCubit>()..getBengkelList(query: query),
          ),
        if (cubit != null) BlocProvider.value(value: cubit)
      ],
      child: _BengkelListWidget(
        query: query,
        scrollController: scrollController,
        isInnerCubit: cubit == null,
      ),
    );
  }
}

class _BengkelListWidget extends StatefulWidget {
  final SGDataQuery? query;

  final ScrollController? scrollController;
  final bool isInnerCubit;
  const _BengkelListWidget(
      {super.key,
      this.query,
      required this.isInnerCubit,
      this.scrollController});

  @override
  State<_BengkelListWidget> createState() => _BengkelListWidgetState();
}

class _BengkelListWidgetState extends State<_BengkelListWidget> {
  @override
  void didUpdateWidget(covariant _BengkelListWidget oldWidget) {
    if (widget.isInnerCubit) {
      if (oldWidget.query != widget.query) {
        context.read<BengkelListCubit>().getBengkelList(query: widget.query);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BengkelListCubit, BengkelListState>(
      builder: (context, state) {
        return switch (state) {
          BengkelListSuccess() => BengkelProfileListWidget(
              profileList: state.bengkelList,
              scrollController: widget.scrollController),
          BengkelListError() => SGError(
              message: state.exception.message,
              retry: () {
                context
                    .read<BengkelListCubit>()
                    .getBengkelList(query: widget.query);
              }),
          BengkelListLoading() => const SGCircularLoading()
        };
      },
    );
  }
}

class BengkelProfileListWidget extends StatelessWidget {
  final List<BengkelProfileWithDistance> profileList;

  final ScrollController? scrollController;
  const BengkelProfileListWidget(
      {super.key, required this.profileList, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: profileList.length,
        controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: BengkelProfileWidget(bengkelProfile: profileList[index]),
            ));
  }
}

class BengkelProfileWidget extends StatelessWidget {
  final BengkelProfileWithDistance bengkelProfile;
  const BengkelProfileWidget({super.key, required this.bengkelProfile});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final bengkel = bengkelProfile.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            SGImagePreview.asFullScreenDialog(context, bengkel.profile);
          },
          child: CircleAvatar(
            backgroundImage: bengkel.profile.provider,
          ),
        ),
        title: Text(
          bengkel.nama,
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            6.verticalSpace,
            Row(children: [
              ...bengkel.jenisLayanan.take(2).map((e) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
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
              if (bengkel.jenisLayanan.length > 2)
                Text("${bengkel.jenisLayanan.length - 2}+")
            ]),
            2.verticalSpace,
            Text(bengkelProfile.distranceString)
          ],
        ),
      ),
    );
  }
}
