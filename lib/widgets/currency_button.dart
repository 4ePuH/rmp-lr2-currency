import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  final String label;
  final String code;
  final VoidCallback? onTap;

  const CurrencyButton({
    super.key,
    required this.label,
    required this.code,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    return OutlinedButton(
      onPressed: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: text.labelSmall),
          Row(
            children: [
              Expanded(
                child: Text(
                  code,
                  style: text.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ],
      ),
    );
  }
}
