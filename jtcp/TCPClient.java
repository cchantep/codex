import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.InputStream;

import java.net.UnknownHostException;
import java.net.Socket;

/**
 * Handle communication client<->server.
 *
 * @author Damota Benoit
 * @author Cedric Chantepie
 */
public class TCPClient extends Thread {
    // --- Properties ---

    /**
     * Socket to the server.
     */
    private Socket server = null;

    /**
     * Reader for input stream from server.
     */
    private BufferedReader reader = null;

    /**
     * Writer to output stream for server.
     */
    private PrintWriter writer = null;

    /**
     * Listener used by this client to handle messages from server.
     */
    private MessageListener listener = null;

    // ---

    /**
     * Thread execution, capture messages from server until connection was closed
     * and pass message to the listener.
     */
    public void run() {
	try {
	    String line = null;

	    while (Thread.currentThread().equals(this) &&
		   (line = this.reader.readLine()) != null) {

		if (line != null) {
		    if (this.listener != null) {
			this.listener.processMessage(line);
		    } // end of if

		    else {
			System.out.println("CLIENT RECEIVED: " + line);
		    } // end of else
		} // end of while

		server.getInputStream();
		
		this.sleep(TCPSessionClient.MESSAGE_DELAY);
	    } // end of while
	} // end of try
	    
	catch (IOException e) {
	    e.printStackTrace();
	} // end of catch
	    
	catch (InterruptedException e) {
	    e.printStackTrace();
	} // end of catch

	// ---

	if (this.listener != null) {
	    this.listener.communicationClosed();
	} // end of if
    } // end of run

    /**
     * Set listener used by this client to handle messages from server.
     *
     * @param listener
     */
    public void setListener(MessageListener listener) {
	listener.setOwner(this);

	this.listener = listener;
    } // end of setListener

    /**
     * Send the |pseudo| choosen by this client to be registered after the server.
     *
     * @param pseudo Choose pseudo.
     * @throws IOException thrown if fails to send pseudo.
     */
    public void sendPseudo(String pseudo) throws IOException {
	StringBuffer buffer = new StringBuffer(pseudo);

	buffer.insert(0, '-');
	buffer.insert(0, TCPSessionClient.PSEUDO_REQUEST);

	send(buffer.toString());
    } // end of sendPseudo

    /**
     * Send text |message| to be dispatched to other clients connected to the server.
     *
     * @param message Message to be dispatched.
     * @throws IOException thrown if fails to send message to the server.
     */
    public void sendMessage(String message) throws IOException {
	StringBuffer buffer = new StringBuffer(message);

	buffer.insert(0, '-');
	buffer.insert(0, TCPSessionClient.DISPATCH_MESSAGE_REQUEST);

	send(buffer.toString());
    } // end of sendMessage

    /**
     * Send a |command| (protocol atom) to the server.
     *
     * @param command Command to be sent to the server.
     * @throws IOException thrown if fails to send |command|.
     * @see TCPSessionClient
     */
    public void send(String command) throws IOException {
	this.writer.println(command);
	this.writer.flush();
    } // end of send

    /**
     * Release resources blocked by this client : reader from, writer to server and server (socket).
     *
     * @throws Throwable thrown if fails to release resources.
     */
    protected void finalize() throws Throwable {
	if (this.reader != null) {
	    this.reader.close();
	} // end of if

	if (this.writer != null) {
	    this.writer.flush();
	    this.writer.close();
	} // end of if

	if (this.server != null) {
	    this.server.close();
	} // end of if
    } // end of finalize

    // --- Constructors ---

    /**
     * Build a client network interface.
     *
     * @param hostname Server hostname.
     * @param port Server port (destination port).
     */
    public TCPClient(String hostname, int port) {
	try {
	    Socket s = new Socket(hostname, port);

	    // stream for server connection
	    InputStream is = s.getInputStream();

	    // reader for stream (@see java.io.StringReader)
	    InputStreamReader isr = new InputStreamReader(is);

	    // add feature to any existing reader (@see #isr)
	    this.reader = new BufferedReader(isr);

	    // ---

	    OutputStream out = s.getOutputStream();

	    this.writer = new PrintWriter(out);
	    
	    this.server = s;

	    this.start();
	} // end of try

	catch (UnknownHostException e) {
	    e.printStackTrace();

	    throw new IllegalArgumentException();
	} // end of catch

	catch (IOException e) {
	    e.printStackTrace();

	    throw new IllegalArgumentException();
	} // end of catch
    } // end of catch

} // end of class TCPClient
