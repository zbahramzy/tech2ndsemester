package Counters;

public class ClassicalCounter {

    private volatile int counter = 0;

    public int getCounter() {
        return counter;
    }

    public void increment() {
        counter += 1;
    }

    public void decrement() {
        counter -= 1;
    }
}
