import 'dart:math';

import 'package:my_rank_tools/controllers/prefsController.dart';
import 'package:my_rank_tools/settings/prefsKeys.dart';

class RankController{
  RankController._();
  static RankController? _instance;
  
  factory RankController(){
    _instance ??= RankController._();
    return _instance!;
  }

  final PrefsController _prefsController = PrefsController();

  double _rankPoint = 5000;
  double get rankPoint => _rankPoint;

  final RANK_DEFAULT_POINT = 50;

  void setRankPoint(double rankPoint){
    _rankPoint = rankPoint;
  }

  double calcWinAndGetDelta(){
    double delta = _calcWinPoint() * RANK_DEFAULT_POINT;
    _rankPoint += delta;
    return delta;
  }

  double calcLoseAndGetDelta(){
    double delta = _calcLosePoint() * RANK_DEFAULT_POINT;
    _rankPoint -= delta;
    _prefsController.setValue(RANK_PREFS, _rankPoint.toInt());
    return delta;
  }

  double _convertValue(double x) {
    return x / 10000;
  }

  double _calcWinPoint(){
    double x = _convertValue(_rankPoint); 
    double A = 1 - x; // xが0に近いほどAが大きくなり、xが1に近いほどAが小さくなります。
    double k = -0.5; // この値を調整して、関数の上がりやすさと下がりやすさを制御します。
    return A * exp(k * x) * 2;
  }

  double _calcLosePoint(){
    double x = _convertValue(_rankPoint); 
    return sin(x * pi);
  }
}
