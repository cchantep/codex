import java.io.FileInputStream;
import java.io.IOException;

public final class Main {

    /**
     */
    public static void main(String[] args) {
	String filename = args[0];

	try {
	    FileInputStream fis = new FileInputStream(filename);
	    Scanner scanner = new Scanner(fis);

	    scanner.yylex();
	} catch (IOException e) {
	    e.printStackTrace();
	} // end of catch
    } // end of <main>

} // end of class Main
