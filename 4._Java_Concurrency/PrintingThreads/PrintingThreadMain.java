package PrintingThreads;

public class PrintingThreadMain {
    public static void main(String[] args) {
        PrintingThread printingThreadOne = new PrintingThread("good to be here today' said Zaland during Tech class.");
        PrintingThread printingThreadTwo = new PrintingThread("31232132183125832175385732585125312875231883271538128");
        PrintingThread printingThreadThree = new PrintingThread("€&%€%&€&#%#&%#&%%/(()&(&(/%%&%/€&#%€!#!#!#€#€%#%&#&((");

        printingThreadOne.start();
        printingThreadTwo.start();
        printingThreadThree.start();
    }
}
