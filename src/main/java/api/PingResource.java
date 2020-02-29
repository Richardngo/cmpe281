package api ;

import org.json.* ;
import org.restlet.representation.* ;
import org.restlet.ext.json.* ;
import org.restlet.resource.* ;
import org.restlet.ext.jackson.* ;

import java.net.InetAddress;
import java.net.UnknownHostException;

import java.io.IOException ;

public class PingResource extends ServerResource {

    @Get
    public Representation get_action (Representation rep) throws IOException {

        String hostname = "" ;
        try {
            hostname = InetAddress.getLocalHost().getHostName() ;
            System.out.println("Hostname: " + hostname) ;
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }    	

        api.Status api = new api.Status() ;
        api.status = "OK" ;
        api.message = "Starbucks API Service on: " + hostname ;
        return new JacksonRepresentation<api.Status>(api) ;

    }


}


