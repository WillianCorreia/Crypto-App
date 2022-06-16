
import 'package:crypto/models/criptomoedas.dart';

class Posicao {
  Criptomoedas criptomoeda;
  double quantidade;

  //CONSTRUTOR
  Posicao({
    required this.criptomoeda,
    required this.quantidade,
  });
}