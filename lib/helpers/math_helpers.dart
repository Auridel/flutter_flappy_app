import 'dart:math';

double generateRandomPipeY(double space) {
  return (Random().nextDouble() * (space - 150)) + 75;
}
