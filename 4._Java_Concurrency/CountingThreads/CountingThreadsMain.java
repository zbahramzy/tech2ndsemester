package CountingThreads;

public class CountingThreadsMain {
    public static void main(String[] args) throws InterruptedException {

        CountingThread countingThreadOne = new CountingThread();
        CountingThread countingThreadTwo = new CountingThread();
        CountingThread countingThreadThree = new CountingThread();

        countingThreadOne.setPriority(Thread.MAX_PRIORITY);
        countingThreadTwo.setPriority(Thread.NORM_PRIORITY);
        countingThreadThree.setPriority(Thread.MIN_PRIORITY);

        countingThreadOne.start();
        countingThreadOne.join();

        countingThreadTwo.start();
        countingThreadThree.start();

    }

}
