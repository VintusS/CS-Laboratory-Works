# Data Encryption Standard
## Author: Cretu Cristian, FAF-223
This assignment focuses on implementing a part of the DES (Data Encryption Standard) encryption algorithm.

## Task
Given a list of 6-bit blocks `[B1,B2,B3,B4,B5,B6,B7,B8]`, show the output of `[S(B1),S(B2),S(B3),S(B4),S(B5),S(B6),S(B7),S(B8)]`

## Theoretical notes
In the DES algorithm, the substitution part takes in 6-bit numbers and outputs 4-bit ones. Each substitution is done based on predefined tables by computing the necessary row and number of the substituting value based on the bits of the input.
### Example
Suppose we have a 6-bit number. We will use the S1 substitution box, which looks like this:
```
14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7 
0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8 
4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0 
15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13 
```
The row number will be the value of the first bit and the second bit concatenated. Or in an easier to visualize way:
```
0xxxx0 - 0
0xxxx1 - 1
1xxxx0 - 2
1xxxx1 - 3
```
The column then would be the number formed from the middle bits. Like this: 
```
x0000x - 0
x0001x - 1
x0010x - 2
x0011x - 3
...
x1111x - 15
```
So, having the 6 bit number 100110, the row will be 2 and the column 3 (both counting from 0), which corresponds to 8.

## Implementation
Since the S-Boxes are predefined and come as additional materials to the DES algorithm, we can create a class that would help us perform operations on them.
```java
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
```
Where we can implement directly a method for finding the substitution for a given number.
```java
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
```
And then we can aggregate instances of this class in another class, so that we can get easy access to our S-Boxes. Since we will need access to another S-Box for each 6-bit block, we will store the S-Boxes in a List which we will access during substitution.
```java
package substituion.substitutionbox;

public class SubstitutionBoxTable {
        private static final SubstitutionBox[] boxes = {
                        new SubstitutionBox(new int[][] {
                                        { 14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7 },
                                        { 0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8 },
                                        { 4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0 },
                                        { 15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13 }
                        }),
                        ... ALL OTHER BOXES
        };

        public SubstitutionBoxTable() {

        }

        public static SubstitutionBox getAt(int index) {
                return boxes[index];
        }

        public static SubstitutionBox[] getBoxes() {
                return boxes;
        }

        public static int size() {
                return boxes.length;
        }
}
```
For it to be easier to understand the algorithm, I have also created a SubstitutionBlock class, which represents just a wrapper for a 6-bit number, allowing to extend the functionality of simple ints.
```java
public class SubstitutionBlock {
    private final int value;

    public SubstitutionBlock(int value) {
        if (value < 0 || value > 63) {
            throw new IllegalArgumentException("Value must be between 0 and 255");
        }
        this.value = value;
    }

    public int getAt(int index) {
        if (index < 0 || index > 5) {
            throw new IllegalArgumentException("Index must be between 0 and 5");
        }
        return (value >> (5 - index)) & 1;
    }

    public int getValue() {
        return value;
    }

    public int getFirstBit() {
        return (value & 0b100000) >> 5;
    }

    public int getLastBit() {
        return value & 0b000001;
    }

    public String toStringAsInt() {
        return Integer.toString(value);
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        for (int i = 5; i >= 0; i--) {
            builder.append(getAt(i));
        }
        return builder.toString();
    }

    public int getMiddleBits() {
        return (value & 0b011110) >> 1;
    }
}
```
### Result
Now we can build the program for the substitution easily like this:
```java
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
```
Which shows:
```
Selected substitution box S1: 
14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7 
0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8 
4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0 
15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13 
Processing block: 38, bit representation: 011001
First bit: 1, last bit: 0, middle bits value: 3
Substituted value: 8

Selected substitution box S2: 
15 1 8 14 6 11 3 4 9 7 2 13 12 0 5 10 
3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5 
0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15 
13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9 
Processing block: 51, bit representation: 110011
First bit: 1, last bit: 1, middle bits value: 9
Substituted value: 6

Selected substitution box S3: 
10 0 9 14 6 3 15 5 1 13 12 7 11 4 2 8 
13 7 0 9 3 4 6 10 2 8 5 14 12 11 15 1 
13 6 4 9 8 15 3 0 11 1 2 12 5 10 14 7 
1 10 13 0 6 9 8 7 4 15 14 3 11 5 2 12 
Processing block: 42, bit representation: 010101
First bit: 1, last bit: 0, middle bits value: 5
Substituted value: 15

Selected substitution box S4: 
7 13 14 3 0 6 9 10 1 2 8 5 11 12 4 15 
13 8 11 5 6 15 0 3 4 7 2 12 1 10 14 9 
10 6 9 0 12 11 7 13 15 1 3 14 5 2 8 4 
3 15 0 6 10 1 13 8 9 4 5 11 12 7 2 14 
Processing block: 60, bit representation: 001111
First bit: 1, last bit: 0, middle bits value: 14
Substituted value: 8

Selected substitution box S5: 
2 12 4 1 7 10 11 6 8 5 3 15 13 0 14 9 
14 11 2 12 4 7 13 1 5 0 15 10 3 9 8 6 
4 2 1 11 10 13 7 8 15 9 12 5 6 3 0 14 
11 8 12 7 1 14 2 13 6 15 0 9 10 4 5 3 
Processing block: 21, bit representation: 101010
First bit: 0, last bit: 1, middle bits value: 10
Substituted value: 15

Selected substitution box S6: 
12 1 10 15 9 2 6 8 0 13 3 4 14 7 5 11 
10 15 4 2 7 12 9 5 6 1 13 14 0 11 3 8 
9 14 15 5 2 8 12 3 7 0 4 10 1 13 11 6 
4 3 2 12 9 5 15 10 11 14 1 7 6 0 8 13 
Processing block: 63, bit representation: 111111
First bit: 1, last bit: 1, middle bits value: 15
Substituted value: 13

Selected substitution box S7: 
4 11 2 14 15 0 8 13 3 12 9 7 5 10 6 1 
13 0 11 7 4 9 1 10 14 3 5 12 2 15 8 6 
1 4 11 13 12 3 7 14 10 15 6 8 0 5 9 2 
6 11 13 8 1 4 10 7 9 5 0 15 14 2 3 12 
Processing block: 0, bit representation: 000000
First bit: 0, last bit: 0, middle bits value: 0
Substituted value: 4

Selected substitution box S8: 
13 2 8 4 6 15 11 1 10 9 3 14 5 0 12 7 
1 15 13 8 10 3 7 4 12 5 6 11 0 14 9 2 
7 11 4 1 9 12 14 2 0 6 10 13 15 3 5 8 
2 1 14 7 4 10 8 13 15 12 9 0 3 5 6 11 
Processing block: 51, bit representation: 110011
First bit: 1, last bit: 1, middle bits value: 9
Substituted value: 12

Selected substitution box S1: 
14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7 
0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8 
4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0 
15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13 
Processing block: 42, bit representation: 010101
First bit: 1, last bit: 0, middle bits value: 5
Substituted value: 6

Selected substitution box S2: 
15 1 8 14 6 11 3 4 9 7 2 13 12 0 5 10 
3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5 
0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15 
13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9 
Processing block: 0, bit representation: 000000
First bit: 0, last bit: 0, middle bits value: 0
Substituted value: 15

Substitution result: 
8 6 15 8 15 13 4 12 6 15 
```
