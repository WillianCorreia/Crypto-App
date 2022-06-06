
import 'package:crypto/models/criptomoedas.dart';

class Posicao {
  Criptomoedas criptomoeda;
  double quantidade;

  Posicao({
    required this.criptomoeda,
    required this.quantidade,
  });
}