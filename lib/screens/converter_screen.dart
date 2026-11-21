import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web/web.dart' as web;

import '../state/converter_state.dart';
import '../utils/format.dart';
import '../widgets/currency_button.dart';
import '../widgets/currency_picker.dart';

class ConverterScreen extends StatefulWidget {
  final ConverterState state;

  const ConverterScreen({super.key, required this.state});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController amountController = TextEditingController();

  ConverterState get state => widget.state;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> pickCurrency(ValueChanged<String> onSelected) async {
    final code = await showCurrencyPicker(context);
    if (mounted && code != null) onSelected(code);
  }

  void onConvert() {
    FocusScope.of(context).unfocus();
    state.convert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Конвертер валют')),
      body: ListenableBuilder(
        listenable: state,
        builder: (context, _) => _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final isLoading = state.isLoading;
    final error = state.requestError;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: amountController,
          readOnly: isLoading,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\- ]')),
          ],
          style: const TextStyle(fontSize: 24),
          decoration: InputDecoration(
            labelText: 'Сумма',
            border: const OutlineInputBorder(),
            errorText: state.inputError,
            suffixText: state.fromCode,
          ),
          onChanged: state.setAmount,
          onSubmitted: (_) => onConvert(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CurrencyButton(
                label: 'Из',
                code: state.fromCode,
                onTap: isLoading ? null : () => pickCurrency(state.setFrom),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Поменять местами',
              onPressed: isLoading ? null : state.swap,
            ),
            Expanded(
              child: CurrencyButton(
                label: 'В',
                code: state.toCode,
                onTap: isLoading ? null : () => pickCurrency(state.setTo),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: isLoading ? null : onConvert,
          child: const Text('Конвертировать'),
        ),
        if (isLoading) ...[
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
        ],
        if (error != null) ...[
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        if (state.result != null) ...[
          const SizedBox(height: 16),
          _ResultCard(state: state),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => web.window.open(
              'https://www.exchangerate-api.com',
              '_blank',
              'noopener,noreferrer',
            ),
            child: const Text('Rates By Exchange Rate API'),
          ),
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  final ConverterState state;

  const _ResultCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final rate = state.rate!;
    final updatedAt = rate.updatedAt;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                '${formatMoney(state.result!)} ${state.toCode}',
                style: text.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '1 ${state.fromCode} = ${formatMoney(rate.value)} ${state.toCode}',
            ),
            if (updatedAt != null)
              Text(
                'Обновлено ${formatDateTime(updatedAt)}',
                style: text.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
