public final class Term {
    // --- Properties ---

    /**
     */
    private Symbol symbol = null;

    /**
     */
    private Term previous = null;

    /**
     */
    private Term next = null;

    /**
     */
    private Term end = null;

    // ---

    /**
     */
    public int getArity() {
	int arity = 1;
	Term t = this;
	Term end = term.getEnd();

	for (; t != end && t != null; t = t.getNext(), arity++);

	this.arity = arity;
    } // end of if

    // --- Constructors ---

    /**
     */
    public Term(Symbol symb) {
	this.previous = this.next = null;
	this.end = this;
	this.symbol = symb;
    } // end of <init>

    /**
     */
    public Term(Symbol symb, Term list) {
	this.symbol = symb;

	this.next = list;
	this.next.previous = this;

	Term last = list;

	for (; last != null; last = last.next);

	this.end = last;
    } // end of <init>

} // end of class Term
