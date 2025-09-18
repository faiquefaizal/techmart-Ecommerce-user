import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/address/cubit/map_cubit.dart';

class MapAddressCard extends StatelessWidget {
  const MapAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubic = context.watch<MapCubit>().state;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.black),
              Flexible(
                child: Text(
                  mapCubic.address.name ?? "NoMame",
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            "${mapCubic.address.street}, ${mapCubic.address.subLocality}, ${mapCubic.address.locality}, ${mapCubic.address.subAdministrativeArea}, ${mapCubic.address.administrativeArea}, ${mapCubic.address.postalCode}, ${mapCubic.address.country}",
            maxLines: 2,

            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
