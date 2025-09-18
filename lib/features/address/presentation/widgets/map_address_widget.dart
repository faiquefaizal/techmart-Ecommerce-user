import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/accounts/presentation/widgets/add_address_button.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/cubit/map_cubit.dart';
import 'package:techmart/features/address/presentation/widgets/add_address_bottonsheet.dart';
import 'package:techmart/features/address/presentation/widgets/map_address_card.dart';
import 'package:techmart/features/address/presentation/widgets/map_address_dropdown.dart';
import 'package:techmart/features/address/presentation/widgets/shimmer_map_address_card.dart';

class MapAddressWidget extends StatelessWidget {
  const MapAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubic = context.watch<MapCubit>().state;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver to", style: Theme.of(context).textTheme.headlineSmall),
          (mapCubic.loading == true)
              ? LoadingMapAddressCard()
              : MapAddressCard(),
          Spacer(),

          InkWell(
            onTap: () {
              showModalBottomSheet(
                clipBehavior: Clip.antiAlias,
                isScrollControlled: true,
                context: context,
                isDismissible: true,
                enableDrag: true,

                builder: (btcontext) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<MapCubit>()),
                      BlocProvider(
                        create:
                            (context) =>
                                CurrentAddressCubicCubit()
                                  ..fillWithMapData(mapCubic.address),
                      ),
                    ],
                    child: MapAddressDropdown(),
                  );
                },
              ).then((_) {
                FocusManager.instance.primaryFocus?.unfocus();
              });
            },
            child: CustemButton(hieght: 45, label: "Add address details"),
          ),
        ],
      ),
    );
  }
}
