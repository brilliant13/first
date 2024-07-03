import 'package:http/http.dart' as http;
import 'dart:convert';

class Stock {
  late String amount;
  late String chagesRatio;
  late String changeCode;
  late String changes;
  late String close;
  late String code; //나중에 가져오는 것이니까 변수 late로 선언해야함.
  late String dept;
  late String isuCd;
  late String low;
  late String marcap;
  late String market;
  late String marketId;
  late String name;
  late String open;
  late String stocks; 
  late String volume;


Stock({
  required this.amount,
  required this.chagesRatio,
  required this.changeCode,
  required this.changes,
  required this.close,
  required this.code,
  required this.dept,
  required this.isuCd,
  required this.low,
  required this.marcap,
  required this.market,
  required this.marketId,
  required this.name,
  required this.open,
  required this.stocks,
  required this.volume,
});

  //  "Amount": 587857572900,
  //     "ChagesRatio": -0.24,
  //     "ChangeCode": "2",
  //     "Changes": -200,
  //     "Close": "81600",
  //     "Code": "005930",
  //     "Dept": "",
  //     "High": 82300,
  //     "ISU_CD": "KR7005930003",
  //     "Low": 81000,
  //     "Marcap": 487134256080000,
  //     "Market": "KOSPI",
  //     "MarketId": "STK",
  //     "Name": "\uc0bc\uc131\uc804\uc790",
  //     "Open": 82300,
  //     "Stocks": 5969782550,
  //     "Volume": 7207674

  factory Stock.fromJson(Map<String, dynamic> json) {
  return Stock(

    amount: json['Amount'] ?? 0,
    chagesRatio: json['ChagesRatio'] ?? '',
    changeCode: json['ChangeCode'] ?? '',
    changes: json['Changes'] ?? '',
    close: json['Close'] ?? '',
    code: json['Code'] ?? '',
    dept: json['Dept'] ?? '',
    isuCd: json['ISU_CD'] ?? '',
    low: json['Low'] ?? '',
    marcap: json['Marcap'] ?? '',
    market: json['Market'] ?? '',
    marketId: json['MarketId'] ?? '',
    name: json['Name'] ?? '',
    open: json['Open'] ?? '',
    stocks: json['Stocks'] ?? '',
    volume: json['Volume'] ?? '', 
  );
 }
}



class StockService {
  Future<List<Stock>> getStocks({int page=1, int ppv=20}) async {
    String url = 'http://192.0.0.1:8070/api/stocks?page=$page&ppv=$ppv'; //base address

    final response= await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Stock> stocks = body.map((dynamic item) => Stock.fromJson(item)).toList();
      return stocks;
    } else {
      throw 'Failed to load stocks';
    }
  }
}