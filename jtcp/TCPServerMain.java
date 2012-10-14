/**
 * Console program starting server.
 *
 * @author Benoit Damota
 * @author Cedric Chantepie
 * @see TCPServer
 */
public final class TCPServerMain {

    /**
     * Start server in console.
     *
     * @param args (1) port (integer).
     */
    public static void main(String[] args) {
	int port = Integer.parseInt(args[0]);
	
	try {
	    TCPServer server = new TCPServer(port);
	    
	    server.startListening();
	} // end of try

	catch (Exception e) {
	    e.printStackTrace(); 
	} // end of catch
    } // end of <main>

} // end of class TCPServerMain


