import java.util.ArrayList;
import java.util.List;

/**
 */
public final class Clause {
    // --- Properties ---

    /**
     */
    private List terms = null;

    // ---

    /**
     */
    public void add(Term term) {
	if (this.terms == null) {
	    this.terms = new ArrayList(1);
	} // end of if

	this.terms.add(term);
    } // end of add

    /**
     * {@inheritDoc}
     */
    public String toString() {
	final int sbSize = 1000;
	final String variableSeparator = ",";
	final StringBuffer sb = new StringBuffer(sbSize);

	sb.append("terms=").append(terms);

	return sb.toString();
    } // end of toString
    
} // end of class
