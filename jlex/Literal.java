public final class Literal {
    // --- Properties ---

    /**
     */
    private boolean sign = false;
    
    /**
     */
    private Term term = null;

    // --- Properties accessors ---

    /**
     * Gets the value of sign
     *
     * @return the value of sign
     */
    public boolean isSign() {
	return this.sign;
    }

    /**
     * Gets the value of term
     *
     * @return the value of term
     */
    public Term getTerm() {
	return this.term;
    }

    // --- Constructors ---

    /**
     */
    public Literal(boolean sign, Term t) {
	this.sign = sign;
	this.term = t;
    } // end of <init>

} // end of class Literal


