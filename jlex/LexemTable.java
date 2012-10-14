import java.util.HashSet;

/**
 */
public final class LexemTable extends HashSet {

    /**
     */
    public Lexem add(String string) {
	Lexem lexem = new Lexem(string);

	if (super.add(lexem)) {
	    return null;
	} // end of if

	return lexem;
    } // end of add
} // end of class LexemTable
