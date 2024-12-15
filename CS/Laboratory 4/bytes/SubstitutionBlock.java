package bytes;

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
