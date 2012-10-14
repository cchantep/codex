/**
 * Handle message from server.
 *
 * @author Damota Benoit
 * @author Cedric Chantepie
 */
public interface MessageListener {
    
    /**
     * Allow client to do what he wants with |message| from server.
     *
     * @param message Message from server.
     */
    public void processMessage(String message);

    /**
     * Specify that the client owning this listener is |owner|.
     *
     * @param owner Listener owner (a client).
     */
    public void setOwner(Object owner);

    /**
     * Socket communication has been closed.
     */
    public void communicationClosed();

} // end of interface MessageListener
