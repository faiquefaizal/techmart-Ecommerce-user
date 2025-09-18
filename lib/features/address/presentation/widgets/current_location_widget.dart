import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/address/cubit/current_location_cubit.dart';

class GetLocationWidget extends StatelessWidget {
  const GetLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      margin: EdgeInsets.only(top: 14, left: 5, right: 5),
      padding: EdgeInsets.all(2),

      child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                strokeAlign: -1,
                strokeWidth: 3,

                color: Colors.white,
              ),
            );
          }

          return TextButton.icon(
            icon: Icon(Icons.gps_fixed, color: Colors.white),
            onPressed: () {
              context.read<CurrentLocationCubit>().fillLocationFilleds();
            },
            label: Text(
              "Get Current location",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
