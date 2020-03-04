package ndtp.domain;

public enum ConsType {
    StepOne(0),
    StepTwo(1),
    StepThree(2),
    StepFour(3),
    StepFive(4),
    StepSix(5);

    private final int value;
    private ConsType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
