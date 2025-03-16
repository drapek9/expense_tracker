class Expense{
  String? name;
  int? category;
  DateTime? time;
  double? prize;
  int? currency;
  double? finalPrizeValue;

  Map<int, String> categoryOptions = {0: "Účty a domácnost", 1: "Jídlo a nápoje",2: "Doprava",3: "Zábava",4: "Zdraví a péče",5: "Oblečení a obuv",6: "Cestování a dovolená"};
  Map<int, String> currencyOptions = {0: "USD", 1: "CZK", 2: "EUR"};
  Map<int, double> compareCurrencyOptions = {0: 0.91, 1: 0.04, 2: 1};

  Expense({required this.name, required this.category, required this.time, required this.prize, required this.currency}) {
    changeFinalPrize();
  }

  void changeFinalPrize (){
    finalPrizeValue = (prize ?? 0)*compareCurrencyOptions[currency]!;
  }
}