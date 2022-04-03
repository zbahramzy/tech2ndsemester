package Deadlock;

public class DeadlockMain {
    public static void main(String[] args) {
        final String lockOne = "I am lock one";
        final String lockTwo = "I am lock two";

        Thread threadOne = new Thread() {
            public void run() {
                synchronized (lockOne) {
                    System.out.println("I am thread 1 I got lock 1");

                    try {
                        sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }

                    synchronized (lockTwo) {
                        System.out.println("I am thread 1 I got lock 2");
                    }
                }
            }
        };

        Thread threadTwo = new Thread() {
            public void run() {
                synchronized (lockTwo) {
                    System.out.println("I am thread 2 I got lock 2");

                    try {
                        sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }

                    synchronized (lockOne) {
                        System.out.println("I am thread 2 I got lock 1");
                    }
                }
            }
        };

        threadOne.start();
        threadTwo.start();
    }
}
