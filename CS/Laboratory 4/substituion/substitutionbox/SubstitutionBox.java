package substituion.substitutionbox;

import bytes.SubstitutionBlock;

public class SubstitutionBox {
    private final int[][] table;

    public SubstitutionBox(int[][] table) {
        this.table = table;
    }

    public int getAt(int row, int col) {
        return table[row][col];
    }

    public int[][] getTable() {
        return table;
    }

    public int substitute(SubstitutionBlock block) {
        int firstBit = block.getFirstBit();
        int lastBit = block.getLastBit();
        int row = firstBit * 2 + lastBit;
        int col = block.getMiddleBits();
        System.out.println("Processing block: " + block.toStringAsInt()
                + ", bit representation: " + block.toString());
        System.out.println(
                "First bit: " + firstBit
                        + ", last bit: " + lastBit
                        + ", middle bits value: " + block.getMiddleBits());
        int substitutedValue = table[row][col];
        System.out.println("Substituted value: " + substitutedValue);
        return substitutedValue;
    }

    public int substitute(int value) {
        return substitute(new SubstitutionBlock(value));
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < table.length; i++) {
            for (int j = 0; j < table[i].length; j++) {
                sb.append(table[i][j]).append(" ");
            }
            if (i != table.length - 1) {
                sb.append("\n");
            }
        }
        return sb.toString();
    }
}
