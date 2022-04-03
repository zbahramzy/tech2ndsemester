package PrintingThreads;

import java.util.concurrent.locks.ReentrantLock;

public class PrintingThread extends Thread {

    String sentence;
    final static Object lock = new Object();
    ReentrantLock reentrantLock = new ReentrantLock();

    public PrintingThread(String sentence) {
        this.sentence = sentence;
    }

    public void run() {
        System.out.println(Thread.currentThread().getName() + " is running");

        reentrantLock.lock();
        //synchronized (lock) {
        for(int i = 0; i < sentence.length(); i++) {
            System.out.print(sentence.charAt(i));
        }
        System.out.println();
        reentrantLock.unlock();

        //}
    }
}
