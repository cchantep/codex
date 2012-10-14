import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import java.net.ServerSocket;
import java.net.Socket;

/**
 * @author Damota Benoit
 * @author Cedric Chantepie
 */
public class TCPServer {
    // --- Properties ---

    /**
     * Server socket listening on specified port.
     */
    private ServerSocket socket = null;

    /**
     * All client sessions.
     */
    private List clients = null;

    // ---

    /**
     * Begin to accept connection from any client/
     */
    public void startListening() {
	while (true) {
	    try {
		Socket s = socket.accept();

		new TCPSessionClient(s, this.clients);
	    } // end of try

	    catch (IOException e) {
		e.printStackTrace();
	    } // end of catch
	} // end of while
    } // end of startListening

    // --- Constructors ---
    
    /**
     * Create a server that will listen for connection on specified |port|.
     *
     * @param port Listening port.
     * @throws IOException thrown if fails to bind properly this server on |port|.
     */
    public TCPServer(int port) throws IOException {
	this.socket = new ServerSocket(port);
	this.clients = new ArrayList();

	System.out.println("SERVER: Started");
    } // end of <init>

} // end of class TCPServer
