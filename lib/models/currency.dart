class Currency {
  final String code;
  final String name;
  final String? country;

  const Currency(this.code, this.name, [this.country]);

  static const supported = [
    Currency('RUB', 'Российский рубль'),
    Currency('EUR', 'Евро'),
    Currency('USD', 'Доллар США'),
    Currency('THB', 'Тайский бат', 'Таиланд'),
    Currency('VND', 'Вьетнамский донг', 'Вьетнам'),
    Currency('IDR', 'Индонезийская рупия', 'Индонезия'),
    Currency('SGD', 'Сингапурский доллар', 'Сингапур'),
    Currency('CNY', 'Юань', 'Китай'),
    Currency('JPY', 'Японская иена', 'Япония'),
    Currency('KRW', 'Южнокорейская вона', 'Южная Корея'),
    Currency('INR', 'Индийская рупия', 'Индия'),
    Currency('AUD', 'Австралийский доллар'),
    Currency('AZN', 'Азербайджанский манат', 'Азербайджан'),
    Currency('DZD', 'Алжирский динар'),
    Currency('GBP', 'Фунт стерлингов'),
    Currency('AMD', 'Армянский драм', 'Армения'),
    Currency('BHD', 'Бахрейнский динар', 'Бахрейн'),
    Currency('BYN', 'Белорусский рубль'),
    Currency('BOB', 'Боливиано'),
    Currency('BRL', 'Бразильский реал'),
    Currency('HUF', 'Венгерский форинт'),
    Currency('HKD', 'Гонконгский доллар', 'Гонконг'),
    Currency('GEL', 'Лари', 'Грузия'),
    Currency('DKK', 'Датская крона'),
    Currency('AED', 'Дирхам ОАЭ', 'ОАЭ'),
    Currency('EGP', 'Египетский фунт'),
    Currency('IRR', 'Иранский риал', 'Иран'),
    Currency('KZT', 'Тенге', 'Казахстан'),
    Currency('CAD', 'Канадский доллар'),
    Currency('QAR', 'Катарский риал', 'Катар'),
    Currency('KGS', 'Кыргызский сом', 'Кыргызстан'),
    Currency('CUP', 'Кубинское песо'),
    Currency('MDL', 'Молдавский лей'),
    Currency('MNT', 'Монгольский тугрик', 'Монголия'),
    Currency('NGN', 'Найр'),
    Currency('NZD', 'Новозеландский доллар'),
    Currency('NOK', 'Норвежская крона'),
    Currency('OMR', 'Оманский риал', 'Оман'),
    Currency('PLN', 'Злотый'),
    Currency('SAR', 'Саудовский риял', 'Саудовская Аравия'),
    Currency('RON', 'Румынский лей'),
    Currency('XDR', 'СДР (специальные права заимствования)'),
    Currency('TJS', 'Сомони', 'Таджикистан'),
    Currency('BDT', 'Бангладешская така', 'Бангладеш'),
    Currency('TRY', 'Турецкая лира', 'Турция'),
    Currency('TMT', 'Новый туркменский манат', 'Туркменистан'),
    Currency('UZS', 'Узбекский сум', 'Узбекистан'),
    Currency('UAH', 'Украинская гривна'),
    Currency('CZK', 'Чешская крона'),
    Currency('SEK', 'Шведская крона'),
    Currency('CHF', 'Швейцарский франк'),
    Currency('ETB', 'Эфиопский быр'),
    Currency('RSD', 'Сербских динаров'),
    Currency('ZAR', 'Южноафриканский рэнд'),
    Currency('MMK', 'Мьянманский кьят', 'Мьянма'),
  ];
}

class ExchangeRate {
  final double value;
  final DateTime? updatedAt;

  const ExchangeRate(this.value, this.updatedAt);
}
