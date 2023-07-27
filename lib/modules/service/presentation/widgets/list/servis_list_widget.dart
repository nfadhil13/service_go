import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/date_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/color_utils.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/loading/circular.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/cubits/cubit/servis_list_cubit.dart';

part 'item.dart';

class ServisListAutoWidget extends StatelessWidget {
  final SGDataQuery? query;
  final ServisListCubit? cubit;
  final void Function(Servis servis)? onTap;
  const ServisListAutoWidget({super.key, this.query, this.cubit, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (cubit == null)
          BlocProvider(
            create: (context) =>
                getIt<ServisListCubit>()..getServisList(query: query),
          ),
        if (cubit != null) BlocProvider.value(value: cubit!)
      ],
      child: _Content(
        query: query,
        onTap: onTap,
        isInnerCubit: cubit == null,
      ),
    );
  }
}

class _Content extends StatefulWidget {
  final SGDataQuery? query;
  final bool isInnerCubit;

  final void Function(Servis servis)? onTap;
  const _Content({this.query, required this.isInnerCubit, this.onTap});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  void didUpdateWidget(covariant _Content oldWidget) {
    if (widget.isInnerCubit) {
      if (oldWidget.query != widget.query) {
        context.read<ServisListCubit>().getServisList(query: widget.query);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServisListCubit, ServisListState>(
      builder: (context, state) {
        return switch (state) {
          ServisListSuccess() => ServisListWidget(
              servisList: state.servisList,
              onTap: widget.onTap,
            ),
          ServisListError() => SGError(
              message: state.exception.message,
              retry: () {
                context
                    .read<ServisListCubit>()
                    .getServisList(query: widget.query);
              }),
          ServisListLoading() => const SGCircularLoading()
        };
      },
    );
  }
}

class ServisListWidget extends StatelessWidget {
  final List<Servis> servisList;
  final void Function(Servis servis)? onTap;
  const ServisListWidget({super.key, required this.servisList, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: servisList.length,
      itemBuilder: (context, index) {
        final data = servisList[index];
        return InkWell(
          onTap: () => onTap?.call(data),
          child: Padding(
            padding: index == servisList.length - 1
                ? EdgeInsets.zero
                : const EdgeInsets.only(bottom: 16),
            child: ServisListItem(servis: data),
          ),
        );
      },
    );
  }
}
