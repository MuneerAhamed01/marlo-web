import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class PayoutButton extends StatelessWidget {
  const PayoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: MarloColors.buttonSub,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            const Icon(Icons.add, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Text('Payout'.toUpperCase(),
                style:
                    Styles.primary.copyWith(fontSize: 14, color: Colors.white)),
            const RotatedBox(
                quarterTurns: 1, child: Divider(color: Colors.white)),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
