import 'package:minesweeper/fundamentals/enum.dart';

class GameSize extends Enum<int> {

  const GameSize(int val) : super (val);

  static const SMALL = const GameSize(10);
  static const MEDIUM = const GameSize(15);
  static const LARGE = const GameSize(20);
}