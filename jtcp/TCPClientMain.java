import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;

/**
 * Console programme using client network interface.
 *
 * @author Benoit Damota
 * @author Cedric Chantepie
 * @see TCPClient
 */
public final class TCPClientMain {
    /**
     * Shortcut to client console.
     */
    private static final String EOT = "EOT";

    /**
     * Alias for PSEUDO_LIST_REQUEST.
     * @see TCPSessionClient#PSEUDO_LIST_REQUEST
     */
    private static final String WHO = "WHO";

    // ---

    /**
     * Start client.
     *
     * @param args (1) hostname ; (2) port ; (3) pseudo for this client.
     */
    public static void main(String[] args) {
	String hostname = args[0];
	int port = Integer.parseInt(args[1]);
	String pseudo = args[2];
	Listener listener = new Listener();
	TCPClient client = 
	    new TCPClient(hostname,
			  port);

	client.setListener(listener);

	try {
	    client.sendPseudo(pseudo);
	    
	    // ---
	    
	    InputStreamReader isr = new InputStreamReader(System.in);
	    BufferedReader buffReader = new BufferedReader(isr);
	    String line = null;

	    while (true) {
		System.out.print("> ");

		if ((line = buffReader.readLine()) == null ||
		    line.equalsIgnoreCase(EOT)) {
		    
		    break;
		} // end of if

		else if (WHO.equalsIgnoreCase(line)) {
		    // aliasing WHO to PSEUDO_LIST_REQUEST
		    client.send(Integer.toString(TCPSessionClient.PSEUDO_LIST_REQUEST));

		    continue; // don't send WHO content so skip the following send
		} // end of else if

		// ---

		client.sendMessage(line);
	    } // end of while

	    System.exit(0);
	} // end of try

	catch (IOException e) {
	    e.printStackTrace();
	} // end of catch
    } // end of main

    // --- Inner classes ---

    /**
     * MessageListener interface to handle messages from server in console mode.
     *
     * @author Damota Benoit
     * @author Cedric Chantepie 
     * @see MessageListener
     */
    private static final class Listener implements MessageListener {
	// --- Constants ---

	/**
	 * String alias for TCPSessionClient#PSEUDO_LIST_OK.
	 *
	 * @see TCPSessionClient#PSEUDO_LIST_OK
	 */
	private static final String PSEUDO_LIST_OK = 
	    Integer.toString(TCPSessionClient.PSEUDO_LIST_OK) + '-';

	/**
	 * String alias for TCPSessionClient#PSEUDO_OK.
	 *
	 * @see TCPSessionClient#PSEUDO_OK
	 */
	private static final String PSEUDO_OK = 
	    Integer.toString(TCPSessionClient.PSEUDO_OK) + '-';

	/**
	 * String alias for TCPSessionClient#DISPATCHED_MESSAGE.
	 *
	 * @see TCPSessionClient#DISPATCHED_MESSAGE
	 */
	private static final String DISPATCHED_MESSAGE = 
	    Integer.toString(TCPSessionClient.DISPATCHED_MESSAGE) + '-';

	/**
	 * String alias for TCPSessionClient#CLIENT_TERMINATION.
	 *
	 * @see TCPSessionClient#CLIENT_TERMINATION
	 */
	private static final String CLIENT_TERMINATION = 
	    Integer.toString(TCPSessionClient.CLIENT_TERMINATION) + '-';

	// --- Properties ---

	/**
	 * Listener owner.
	 */
	private TCPClient client = null;

	/**
	 * Client pseudo.
	 */
	private String pseudo = null;

	// ---

	/**
	 * Display a received |message| in console.
	 */
	private static void displayMsg(String message) {
	    System.out.println();
	    System.out.println(message);
	    System.out.print("> ");
	} // end of displayMsg

	/**
	 * Specify that the client owning this listener is |owner|.
	 *
	 * @param owner Listener owner (a client).
	 */
	public void setOwner(Object owner) {
	    this.client = (TCPClient) owner;
	} // end of setOwner

	/**
	 * Allow client to do what he wants with |message| from server.
	 *
	 * @param message Message from server.
	 */
	public void processMessage(String message) {
	    if (message.startsWith(PSEUDO_OK)) {
		displayMsg("CLIENT: AUTHENTIFICATION OK");

		String pseudo = message.substring(message.indexOf("-")+1);

		this.pseudo = pseudo;
	    } // end of if

	    else if (message.startsWith(PSEUDO_LIST_OK)) {
		String pseudo = message.substring(message.indexOf("-")+1);

		displayMsg("CLIENT: PSEUDO LIST \"" + pseudo + '"');
	    } // end of else if

	    else if (message.startsWith(DISPATCHED_MESSAGE)) {
		message = message.substring(message.indexOf("-")+1);

		String emitter = message.substring(0, message.indexOf("-"));

		message = message.substring(message.indexOf("-")+1);

		displayMsg("CLIENT: MESSAGE FROM \"" + emitter + 
			   "\" : " + message + '"');

	    } // end of else if

	    else if (message.startsWith(CLIENT_TERMINATION)) {
		String pseudo = message.substring(message.indexOf("-")+1);

		System.out.println("CLIENT: \"" + pseudo + "\" HAS QUIT");
	    } // end of else if

	    else {
		System.err.println("Unsupported message \"" + message + '"');
	    } // end of else
	} // end of processMessage

	/**
	 * Socket communication has been closed.
	 */
	public void communicationClosed() {
	    System.err.println("CLIENT: SERVER HAS CLOSED");

	    System.exit(0);
	} // end of communicationClosed
    } // end of class Listener
    
} // end of class TCPClientMain
