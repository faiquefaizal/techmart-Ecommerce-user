import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/choice_chips.dart/cubit/selected_chips_cubit.dart';

List<String> options = ["All", "Apple", "Vivo", "Samsung", "Sony"];

class CustemChoiceChips extends StatelessWidget {
  const CustemChoiceChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedChipsCubit, String>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                options.map((element) {
                  bool seleted = element == state;
                  return Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        element,
                        style: TextStyle(
                          color:
                              seleted
                                  ? const Color.fromARGB(255, 230, 120, 120)
                                  : Colors.black,
                        ),
                      ),
                      selected: seleted,

                      // selectedColor: Colors.black,
                      color: WidgetStateProperty.resolveWith<Color>((state) {
                        if (state.contains(WidgetState.selected)) {
                          return Colors.black;
                        }

                        return Colors.white;
                      }),
                      onSelected:
                          (_) => context
                              .read<SelectedChipsCubit>()
                              .selectChoips(element),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
