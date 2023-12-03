class DoMath {
  List characters;
  List formatedMath = [];
  String result = "";
  List<String> operands = ['/', '*', '+', '-'];

  DoMath(this.characters);

  makeFloat(String str) {
    return str.substring(str.length - 1) == "." ? "${str}0" : str;
  }

  createMath() {
    try {
      // this holds the math expression
      String holder = "";
      for (var character in characters) {
        if (operands.contains(character)) {
          if (holder.isNotEmpty) {
            formatedMath.add(double.parse(makeFloat(holder)));
          }

          if (character == "-") {
            character = "+";
            holder = "-";
          } else {
            holder = "";
          }

          formatedMath.add(character);
          continue;
        }
        holder += character;
      }

      if (holder.isNotEmpty) {
        formatedMath.add(double.parse(makeFloat(holder)));
      }

      return true;
    } catch (e) {
      result = "Syntax error";
      return false;
    }
  }

// checks the operant position
  validate(indexOfCharacter, len, operand) {
    if (indexOfCharacter == 0) {
      if (operand == "/" ||
          operand == "*" ||
          len < 2 ||
          formatedMath[1] is! double) {
        result = "Syntax error";
        return false;
      }
      if (operand == "-") {
        formatedMath[1] *= -1;
      }
      formatedMath.removeAt(0);
      return "continue";
    } else if (indexOfCharacter == len - 1 ||
        formatedMath[len - 1] is! double) {
      // there is nothing at the end
      result = "Syntax error";
      return false;
    }
    return "validated";
  }

  calculate() {
    if (createMath()) {
      int index = 0;
      String operand;
      int indexOfCharacter;

      while (index < 4) {
        int len = formatedMath.length;
        operand = operands[index];
        indexOfCharacter = formatedMath.indexOf(operand);
        // there is an operant here
        if (indexOfCharacter != -1) {
          var isValid = validate(indexOfCharacter, len, operand);

          if (isValid == false) {
            break;
          }

          if (isValid == "continue") {
            continue;
          }
          // here the operant is not at the begining
          // now we check the previous value
          if (formatedMath[indexOfCharacter - 1] is! double) {
            if ((formatedMath[indexOfCharacter - 1] != "+" &&
                    formatedMath[indexOfCharacter - 1] != "-") ||
                operand == "/" ||
                operand == "*" ||
                formatedMath[indexOfCharacter - 2] is! double) {
              result = "Syntax error";
              break;
            }

            formatedMath.removeAt(indexOfCharacter);
            continue;
          }

          // we check the next
          if (formatedMath[indexOfCharacter + 1] is! double) {
            if ((formatedMath[indexOfCharacter + 1] != "+" &&
                    formatedMath[indexOfCharacter + 1] != "-") ||
                formatedMath[indexOfCharacter + 2] is! double) {
              result = "Syntax error";
              break;
            }

            switch (operand) {
              case "+":
                if (formatedMath[indexOfCharacter + 1] == "-") {
                  formatedMath[indexOfCharacter] = "-";
                }

                break;
              case "-":
                if (formatedMath[indexOfCharacter + 1] == "-") {
                  formatedMath[indexOfCharacter] = "+";
                  index--;
                }

                break;
              default:
                if (formatedMath[indexOfCharacter + 1] == "-") {
                  formatedMath[indexOfCharacter + 2] *= -1;
                }
            }
            formatedMath.removeAt(indexOfCharacter + 1);
            continue;
          }

          switch (operand) {
            case "+":
              formatedMath[indexOfCharacter - 1] =
                  formatedMath[indexOfCharacter - 1] +
                      formatedMath[indexOfCharacter + 1];
              break;
            case "-":
              formatedMath[indexOfCharacter - 1] =
                  formatedMath[indexOfCharacter - 1] -
                      formatedMath[indexOfCharacter + 1];
              break;
            case "*":
              formatedMath[indexOfCharacter - 1] =
                  formatedMath[indexOfCharacter - 1] *
                      formatedMath[indexOfCharacter + 1];
              break;
            case "/":
              if (formatedMath[indexOfCharacter + 1] == 0) {
                result = "Math error";
                break;
              }
              formatedMath[indexOfCharacter - 1] =
                  formatedMath[indexOfCharacter - 1] /
                      formatedMath[indexOfCharacter + 1];
              break;
            default:
              result = "Syntax error";
              break;
          }

          formatedMath.removeAt(indexOfCharacter);
          formatedMath.removeAt(indexOfCharacter);
        } else {
          index++;
        }
      }

      if (result.isEmpty) {
        if (formatedMath.isNotEmpty) {
          result = formatedMath[0].toString();
        } else {
          result = "Error!";
        }
      }
    }
  }
}
