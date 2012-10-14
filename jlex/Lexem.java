
public final class Lexem {
    // --- Properties ---

    /**
     */
    private String string = null;

    // ---

    /**
     */
    public String getContent() {
	return this.string;
    }  // end of getContent

    /**
     */
    public int hashCode() {
	return (this.string == null) ? 0 : 
	    this.string.hashCode();

    } // end of hashCode

    // --- Constructors ---

    /**
     */
    public Lexem(String string) {
	this.string = string;
    } // end of <init>
} // end of class Lexem
