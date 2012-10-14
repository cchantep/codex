import java.util.Iterator;
import java.util.List;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.InputStream;

import java.net.Socket;

/**
 * Client session, define protocol.
 *
 * @author Damota Benoit
 * @author Cedric Chantepie
 */
public class TCPSessionClient extends Thread {
    // --- Constants ---

    /**
     * Delay between message.
     */
    public static final int MESSAGE_DELAY = 1000;

    // request codes

    /**
     * Request to be registred as a specified pseudo.
     */
    public static final int PSEUDO_REQUEST = 121;

    /**
     * Code to request logged pseudo list.
     */
    public static final int PSEUDO_LIST_REQUEST = 122;

    /**
     * Ask the server to dispatch a text message to other clients.
     */
    public static final int DISPATCH_MESSAGE_REQUEST = 123;

    // response codes

    /**
     * Text message has been properly dispatched to other client.
     */
    public static final int CODE_OK = 220;

    /**
     * Pseudo registration is ok.
     */
    public static final int PSEUDO_OK = 221;

    /**
     * Indicates is sending a pseudo among clients connected to the server.
     */
    public static final int PSEUDO_LIST_OK = 222;

    /**
     * Indicates client is receiving a message from another client.
     */
    public static final int DISPATCHED_MESSAGE = 223;

    /**
     * Indicates client that another client has quit.
     */
    public static final int CLIENT_TERMINATION = 224;

    /**
     * Indicates that pseudo registration has failed (error).
     */
    public static final int PSEUDO_ALREADY_RECEIVED = 421;

    // --- Properties ---

    /**
     * Socket to client.
     */
    private Socket client = null;

    /**
     * Reader for input stream from client.
     */
    private BufferedReader reader = null;

    /**
     * Writer to output stream to client/
     */
    private PrintWriter writer = null;

    /**
     * List of all clients connected to the server (given by the server).
     * @see TCPServer
     */
    private List clients = null;

    /**
     * Prevent pseudo to be deregistered.
     */
    private boolean pseudoReceived = false;

    /**
     * Own pseudo.
     */
    private String pseudo = null;

    // ---

    /**
     * Capture message from the client until connection was closed.
     *
     * @see #handleMessage(String)
     */
    public void run() {
	try {
	    String line = null;

	    while (Thread.currentThread().equals(this) &&
		   (line = this.reader.readLine()) != null) {

		try {
		    this.handleMessage(line);

		    this.sleep(MESSAGE_DELAY);
		} // end of try
		
		catch (InterruptedException e) {
		    e.printStackTrace();
		} // end of catch
	    } // end of while
	} // end of try 
	
	catch (IOException e) {
	    e.printStackTrace();
	} // end of catch

	fireDisconnection();
    } // end of run

    /**
     * Indicates to all other clients that this client is quitting.
     */
    private void fireDisconnection() {
	StringBuffer buffer = new StringBuffer();

	this.clients.remove(this);

	buffer.setLength(0);
	buffer.append(CLIENT_TERMINATION).
	    append('-').append(this.pseudo);

	this.dispatchToOthers(buffer.toString());
    } // end of fireDisconnection

    /**
     * Treat |message| (or command) from client and fire appropriate action.
     *
     * @param message Message from client.
     */
    private void handleMessage(String message) {
	message = message.trim();
	
	System.out.println("SERVER: Received \"" + message + '"');

	StringBuffer buffer = new StringBuffer();
	
	if (message.startsWith(Integer.toString(PSEUDO_REQUEST) + '-')) {
	    String pseudo = message.substring(message.indexOf('-')+1);

	    if (pseudoReceived) {
		buffer.append(PSEUDO_ALREADY_RECEIVED).
		    append('-').append(pseudo);

	    } // end of if

	    else {
		buffer.append(PSEUDO_OK).
		    append('-').append(pseudo);

		this.pseudoReceived = true;
		this.pseudo = pseudo;
	    } // end of else

	    this.writer.println(buffer.toString());
	    this.writer.flush();
	} // end of if

	else if (message.startsWith(Integer.toString(PSEUDO_LIST_REQUEST))) {
	    Iterator iter = this.clients.iterator();
	    
	    while (iter.hasNext()) {
		TCPSessionClient client = (TCPSessionClient) iter.next();
		String pseudo = client.pseudo;

		buffer.setLength(0);
		buffer.append(PSEUDO_LIST_OK).
		    append('-').append(pseudo);

		this.writer.println(buffer.toString());
		this.writer.flush();
	    } // end of while
	} // end of else if
	    
	else if (message.startsWith(Integer.toString(DISPATCH_MESSAGE_REQUEST))) {
	    message = message.substring(message.indexOf('-')+1);

	    this.dispatchMessage(message);
	} // end of else

	else {
	    System.err.println("Unsupported message");
	} // end of else
    } // end of handleMessage

    /**
     * Dispatch text |message| to others.
     *
     * @param message Message received from client, to be dispatched to others.
     */
    private void dispatchMessage(String message) {
	StringBuffer buffer = new StringBuffer(0);
	Iterator iter = this.clients.iterator();

	buffer.append(DISPATCHED_MESSAGE).
	    append('-').append(this.pseudo).
	    append('-').append(message);
	
	this.dispatchToOthers(buffer.toString());

	// ---
	
	int offset = Integer.toString(DISPATCHED_MESSAGE).length();
	
	buffer.setLength(0);
	buffer.append(CODE_OK).
	    append('-').append(message);

	this.writer.println(buffer.toString());
	this.writer.flush();
    } // end of dispatchMessage

    /**
     * Dispatch |message| (or command) clients except this one.
     *
     * @param message Message to be dispatched.
     */
    private void dispatchToOthers(final String message) {
	Iterator iter = this.clients.iterator();

	while (iter.hasNext()) {
	    TCPSessionClient client = (TCPSessionClient) iter.next();

	    if (this.equals(client) || client == null) {
		// skip self client
		continue;
	    } // end of if

	    // ---

	    client.writer.println(message);
	    client.writer.flush();
	} // end of while
    } // end of dispatchToOthers

    // ---

    /**
     * Release resources blocked by this client session : 
     * writer to, reader from client and client itself (socket).
     */
    protected void finalize() throws Throwable {
	if (this.writer != null) {
	    this.writer.flush();
	    this.writer.close();
	} // end of if

	if (this.reader != null) {
	    this.reader.close();
	} // end of if

	if (this.client != null) {
	    this.client.close();
	} // end of if
    } // end of finalize

    /**
     * Returns unique hash code for client.
     */
    public int hashCode() {
	if (this.pseudo == null) {
	    return -1;
	} // end of if

	else {
	    return this.pseudo.hashCode();
	} // end of else
    } // end of hashCode

    /**
     * Checks whether other is a client equals to this, with same pseudo.
     *
     * @param other Supposed other client to be compared with this one.
     */
    public boolean equals(Object other) {
	if (other == null || !(other instanceof TCPSessionClient)) {
	    return false;
	} // end of if

	else {
	    TCPSessionClient client = (TCPSessionClient) other;

	    return ((client.pseudo == null && this.pseudo == null) ||
		    (client.pseudo != null && client.pseudo.equals(this.pseudo)));

	} // end of else
    } // end of equals

    /**
     * Returns descriptive text for this client session.
     */
    public String toString() {
	return super.toString() + "[pseudo=" + this.pseudo + ']';
    } // end of toString

    // ---

    /**
     * Create a session client managing communication with specified |client|.
     *
     * @param client Own client.
     * @param clients Reference to other clients list (from server).
     * @see TCPServer
     */
    public TCPSessionClient(Socket client, List clients) {
	try {
	    // stream from client connection
	    InputStream is = client.getInputStream();
	    InputStreamReader isr = new InputStreamReader(is);

	    this.reader = new BufferedReader(isr);

	    // ---

	    OutputStream out = client.getOutputStream();

	    if (clients.contains(this)) {
		throw new RuntimeException("SERVER: Client \"" + this + "\" already logged in");
	    } // end of if

	    // ---

	    clients.add(this);

	    this.writer = new PrintWriter(out);
	    this.client = client;
	    this.clients = clients;
	    
	    this.start();
	} // end of try

	catch (IOException e) {
	    throw new IllegalArgumentException();
	} // end of catch
    } // end of <init>

} // end of class TCPSessionClient
