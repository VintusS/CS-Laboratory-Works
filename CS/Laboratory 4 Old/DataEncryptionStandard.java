import java.util.List;

import bytes.SubstitutionBlock;
import substituion.substitutionbox.SubstitutionBox;
import substituion.substitutionbox.SubstitutionBoxTable;

public class DataEncryptionStandard {
  public static void main(String[] args) {
    List<SubstitutionBlock> blocks = List.of(
        new SubstitutionBlock(0b100110),
        new SubstitutionBlock(0b110011),
        new SubstitutionBlock(0b101010),
        new SubstitutionBlock(0b111100),
        new SubstitutionBlock(0b010101),
        new SubstitutionBlock(0b111111),
        new SubstitutionBlock(0b000000),
        new SubstitutionBlock(0b110011),
        new SubstitutionBlock(0b101010),
        new SubstitutionBlock(0b000000));
    int[] substitutionResult = new int[blocks.size()];
    for (int i = 0; i < blocks.size(); i++) {
      int substituionBoxIndex = i % SubstitutionBoxTable.size();
      SubstitutionBox substitutionBox = SubstitutionBoxTable.getAt(substituionBoxIndex);
      System.out.println(
          "Selected substitution box S"
              + (substituionBoxIndex + 1) + ": \n"
              + substitutionBox.toString());
      substitutionResult[i] = substitutionBox.substitute(blocks.get(i));
      System.out.println();
    }
    System.out.println("Substitution result: ");
    for (int i = 0; i < substitutionResult.length; i++) {
      System.out.print(substitutionResult[i] + " ");
    }
  }
}
