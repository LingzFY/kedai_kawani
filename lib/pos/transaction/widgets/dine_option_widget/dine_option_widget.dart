import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';

class DineOptionWidget extends StatelessWidget {
  const DineOptionWidget({super.key, required this.dineOption});

  final double dineOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 48.0,
          child: ElevatedButton(
            onPressed: () {
              context.read<TransactionBloc>().add(
                    ChangeDineOption(
                      dineOption: 0,
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (dineOption == 0) ? Colors.orange : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "Dine In",
              style: TextStyle(
                color: (dineOption == 0) ? Colors.white : Colors.orange,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        SizedBox(
          height: 48.0,
          child: ElevatedButton(
            onPressed: () {
              context.read<TransactionBloc>().add(
                    ChangeDineOption(
                      dineOption: 1,
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (dineOption == 1) ? Colors.orange : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "Take Away",
              style: TextStyle(
                color: (dineOption == 1) ? Colors.white : Colors.orange,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
