//Content translater
// lab2 task1
import ballerina/http;
import ballerinax/docker;

@docker:Config {
    name: "lonewolf/content-translater"
}

listener http:Listener my_listener = new(9090,
    config = {httpVersion: "2.0"}
);

@http:ServiceConfig {
    basePath: "/"
}

service lingoService on my_listener {
    
    @http:ResourceConfig{
        methods: ["GET"],
        path: "/EN"
    }

    resource function english(http:Caller caller, http:Request request) {
        http:Response response=new;
        string text = "Good morning, how are you?\nI'm doing fine.\nCan you please assist me with some water?\nThank you very much!!";
        response.setPayload(untaint text);
        var result = caller -> respond(response);
    }

    @http:ResourceConfig{
        methods: ["GET"],
        path: "/FR"
    }

    resource function french(http:Caller caller, http:Request request) {
        http:Response response=new;
        string text = "Bonjour comment-allez vous?\nJe vais bien.\nPouvez-vous m'aider s'il vous plaît avec de l'eau?\nMerci beaucoup!!";
        response.setPayload(untaint text);
        var result = caller -> respond(response);
    }

    @http:ResourceConfig{
        methods: ["GET"],
        path: "/SH"
    }

    resource function oshiwambo(http:Caller caller, http:Request request) {
        http:Response response=new;
        string text = "Walelepo\nOnawa.\nAlikana kwafelange omeya\nTangi unene!!";
        response.setPayload(untaint text);
        var result = caller -> respond(response);
    }

    @http:ResourceConfig{
        methods: ["GET"],
        path: "/DB"
    }

    resource function damara(http:Caller caller, http:Request request) {
        http:Response response=new;
        string text = "Walaapo tuu nawa\nAme ndjili nawa\nNdjipawo omeva\nChetu vaketu!!";
        response.setPayload(untaint text);
        var result = caller -> respond(response);
    }
}

