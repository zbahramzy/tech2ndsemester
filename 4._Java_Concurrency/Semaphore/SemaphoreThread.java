package Semaphore;

import java.util.concurrent.Semaphore;

public class SemaphoreThread extends Thread {
    final private Semaphore semaphore;

    public SemaphoreThread(Semaphore semaphore) {
        this.semaphore = semaphore;
    }

    public void run() {
        try {
            semaphore.acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        for (int i = 0; i <= 100; i++) {
            if (i==50) {
                semaphore.release();
            }
            System.out.println(i);
        }
    }
}
