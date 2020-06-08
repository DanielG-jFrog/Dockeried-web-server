
import com.sun.net.httpserver.HttpServer
import groovy.json.*


HttpServer.create(new InetSocketAddress(8080), /*max backlog*/ 0).with {
    println "Server is listening on 8080"
    createContext("/") { http ->
        http.responseHeaders.add("Content-type", "text/plain")
        http.sendResponseHeaders(200, 0)
        http.responseBody.withWriter { out ->
            out << "Hello from Docker container"
        }
    }

    start()
}

