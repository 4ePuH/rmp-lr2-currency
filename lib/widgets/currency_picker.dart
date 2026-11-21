import 'package:flutter/material.dart';

import '../models/currency.dart';

Future<String?> showCurrencyPicker(BuildContext context) {
  const currencies = Currency.supported;
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          final currency = currencies[index];
          final country = currency.country;
          return ListTile(
            leading: SizedBox(width: 40, child: Text(currency.code)),
            title: Text(
              currency.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: country == null ? null : Text(country),
            onTap: () => Navigator.pop(context, currency.code),
          );
        },
      ),
    ),
  );
}
