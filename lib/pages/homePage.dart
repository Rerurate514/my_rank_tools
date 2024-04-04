import 'package:flutter/material.dart';
import 'package:my_rank_tools/controllers/prefsController.dart';
import 'package:my_rank_tools/controllers/rankController.dart';
import 'package:my_rank_tools/settings/paddingSettings.dart';
import 'package:my_rank_tools/settings/prefsKeys.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final PrefsController _prefsController = PrefsController();
  final RankController _controller = RankController();

  int _rankPoint = 5000;
  int _delta = 0;

  @override
  void initState(){
    super.initState();
    initValue();
  }

  void initValue() async {
    _rankPoint = await _prefsController.getValue(RANK_PREFS) ?? 5000;
    _controller.setRankPoint(_rankPoint.toDouble());
  }

  void _setRankPoint() {
    setState(() {
      _rankPoint = _controller.rankPoint.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: PagePadding().value(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "NOW YOUR RANK",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              "$_rankPoint",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              )
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                // thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                // overlayShape: const RoundSliderOverlayShape(overlayRadius: 30),
              ),
              child: Slider(
                value: _rankPoint.toDouble(),
                min: 0,
                max: 10000,
                divisions: 1000,
                label: _rankPoint.toString(),
                onChanged: (_) {}
              )
            ),
            Padding(padding: VerticalPadding().value(context)),
            buildBtns(),
            Padding(padding: VerticalPadding().value(context)),
            Text(
              "DELTA $_delta",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen
              )
            ),
            Padding(padding: VerticalPadding().value(context)),
          ],
        ),
      ),
    );
  }

  Widget buildBtns(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildBtn(
          "lose", 
          const Icon(
            Icons.thumb_down,
            color: Colors.red,
          ),
          () {
            _delta = _controller.calcLoseAndGetDelta().toInt();
            _setRankPoint();
          }
        ),
        Padding(padding: HorizontalPadding().value(context),),
        buildBtn(
          "Win", 
          const Icon(
            Icons.thumb_up,
            color: Colors.blue,
          ),
          () {
            _delta = _controller.calcWinAndGetDelta().toInt();
            _setRankPoint();
          }
        ),
      ],
    );
  }

  Widget buildBtn(String title, Widget icon, Function() onTap){
    return SizedBox(
      height: 64,
      width: 64,
      child: InkWell(
        borderRadius: BorderRadius.circular(64),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
      ),
    );
  }
}