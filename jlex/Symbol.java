public final class Symbol {
    // --- Constants ---

    /**
     */
    public static final int VARIABLE = 0x1;

    /**
     */
    public static final int CONSTANT = 0x2;

    /**
     */
    public static final int COMPLEX = 0x3;

    /**
     */
    public static final int FUNCTION = 0x4;

    // --- Properties ---

    /**
     */
    private Lexem lexem = null;

    /**
     */
    private int arity = -1;

    /**
     */
    private int identifier = -1;

    /**
     */
    private int type = -1;

    // ---

    /**
     */
    public Lexem getLexem() {
	return this.lexem;
    } // end of getLexem

    /**
     */
    public int getType() {
	return this.type;
    } // end of getType

    /**
     */
    public int getArity() {
	if (type != COMPLEX) {
	    return 1;
	} // end of if

	return this.arity;
    } // end of getArity

    /**
     */
    public int getIdentifier() {
	return this.identifier;
    } // end of getIdentifier

    /**
     */
    public String getName() {
	return lexem.getContent();
    } // end of getName

    /**
     */
    public void setIdentifier(int id) {
	this.identifier = id;
    } // end of setIdentifier

    /**
     */
    void setType(int t) {
	this.type = type;
    } // end of setType

    void setArity(int a) {
	this.arity = a;
    } // end of setArity
	
    /**
     */
    public boolean isVariable() {
	return (this.type == VARIABLE);
    } // end of isVariable

    /**
     */
    public boolean isConstant() {
	return (this.type == CONSTANT);
    } // end of isConstant

    /**
     */
    public boolean isComplex() {
	return (this.type == COMPLEX);
    } // end of isComplex

    /**
     */
    public void declareArity(Term term) {
	if (term == null) {
	    this.arity = 0;

	    return;
	} // end of if

	this.arity = term.getArity();
    } // end of declareArity

    // --- Constructors ---

    /**
     */
    Symbol(Lexem l) {
	this.lexem = l;
    } // end of <init>

} // end of class Symbol
