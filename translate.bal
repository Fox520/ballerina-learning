import ballerina/http;
import ballerina/io;
import ballerinax/docker;

@docker:Config {
    name: "lonewolf/dynamic-language"
}

http:Client http2serviceClientEP = new("http://localhost:7090",
    config = { httpVersion: "2.0" });
@http:ServiceConfig {
    basePath: "/assistant"
}

service languageAssistant on new http:Listener(8080) {
    @http:ResourceConfig{
        path: "/{code}",
        methods: ["GET"]
    }
    resource function controllerResource(http:Caller caller, http:Request request, string code) {
        error? result;
        http:Response|error response = new;
        match code{
            "EN" => {
                response = http2serviceClientEP -> forward("/english", request);
            }
            "FR" => {
                response = http2serviceClientEP -> forward("/french", request);
            }
            "SH" => {
                response = http2serviceClientEP -> forward("/oshiwambo", request);
            }
            "DB" => {
                response = http2serviceClientEP -> forward("/oludhemba", request);
            }
            
        }
        if!(response is error){
            result = caller -> respond(response);
        }else{
            io:println(response.detail());
            result = caller -> respond("language not found");
        }
        
        
    }
}

listener http:Listener http2serviceEP = new(7090,
    config = { httpVersion: "2.0" });

@http:ServiceConfig {
    basePath: "/english"
}

service serviceEnglish on http2serviceEP {
    @http:ResourceConfig {
        path: "/"
    }
    resource function newResource(http:Caller caller, http:Request request) {
        io:println(request);
        http:Response res = new;
        string text = "Good morning, how are you?\nI'm doing fine.\nCan you please assist me with some water?\nThank you very much!!";
        res.setTextPayload(text, contentType = "text/plain");
        error? result = caller -> respond(res);
    }
}

@http:ServiceConfig {
    basePath: "/french"
}

service serviceFrench on http2serviceEP {
    @http:ResourceConfig {
        path: "/"
    }
    resource function newResource(http:Caller caller, http:Request request) {
        http:Response res = new;
        string text = "Bonjour comment-allez vous?\nJe vais bien.\nPouvez-vous m'aider s'il vous plaît avec de l'eau?\nMerci beaucoup!!";
        res.setTextPayload(text, contentType = "text/plain");
        error? result = caller -> respond(res);
    }
}

@http:ServiceConfig {
    basePath: "/oshiwambo"
}

service serviceOshiwambo on http2serviceEP {
    @http:ResourceConfig {
        path: "/"
    }
    resource function newResource(http:Caller caller, http:Request request) {
        io:println(request);
        http:Response res = new;
        string text = "Walelepo\nOnawa.\nAlikana kwafelange omeya\nTangi unene!!";
        res.setTextPayload(text, contentType = "text/plain");
        error? result = caller -> respond(res);
    }
}

@http:ServiceConfig {
    basePath: "/oludhemba"
}

service serviceOludhemba on http2serviceEP {
    @http:ResourceConfig {
        path: "/"
    }
    resource function newResource(http:Caller caller, http:Request request) {
        http:Response res = new;
        string text = "Walaapo tuu nawa\nAme ndjili nawa\nNdjipawo omeva\nChetu vaketu!!";
        res.setTextPayload(text, contentType = "text/plain");
        error? result = caller -> respond(res);
    }
}
