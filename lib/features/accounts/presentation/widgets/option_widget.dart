import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';
import 'package:techmart/features/track_order/cubit/track_order_cubit.dart';
import 'package:techmart/features/track_order/service/track_order_service.dart';

class OptionWidget extends StatelessWidget {
  Widget pushScreenWidget;
  String name;
  Widget icon;
  bool wrapWithCubic;

  OptionWidget({
    super.key,
    required this.pushScreenWidget,
    required this.name,
    required this.icon,
    this.wrapWithCubic = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final finalWidget =
            wrapWithCubic
                ? MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => TabSelectCubic()),
                    BlocProvider(
                      create: (context) => TrackOrderCubit(TrackOrderService()),
                    ),
                  ],
                  child: pushScreenWidget,
                )
                : pushScreenWidget;
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => finalWidget));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            spacing: 15,
            children: [
              icon,
              Text(name, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }
}
