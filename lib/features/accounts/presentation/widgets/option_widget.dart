import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';

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
    return GestureDetector(
      onTap: () {
        final finalWidget =
            wrapWithCubic
                ? BlocProvider(
                  create: (context) => TabSelectCubic(),
                  child: pushScreenWidget,
                )
                : pushScreenWidget;
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => finalWidget));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 15,
          children: [
            icon,
            Text(name, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  VoidCallback ontap;
  String name;
  Icon icon;
  SignOut({
    super.key,
    required this.ontap,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 15,
          children: [
            icon,

            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
