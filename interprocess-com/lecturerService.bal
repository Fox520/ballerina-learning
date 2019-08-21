import ballerina/http;
import ballerina/io;

map<json> courses = {
    "DSP620S":{
        "Name":       "Distributed Systems Programming",
        "Start date": "Today",
        "abstract": "This course is designed to expose the student to techniques and "+ 
                    "procedures used in developing distributed systems."
        }
};
map<json> lecturers = {
    "DSP620S": {
        "name":"Mr. JJ",
        "age":22
        }
};

@http:ServiceConfig {
    basePath: "/lecturer-management"
}

service lectureService on new http:Listener(9092) {
    
    @http:ResourceConfig{
        path: "/remarks",
        methods: ["POST"]
    }

    resource function getInfo(http:Caller caller, http:Request request) returns error? {
        http:Response res = new;
        json incomingJSON = check request.getJsonPayload();
        string courseCode = check string.convert(incomingJSON["courseID"]);
        // instructions require manual input but we automate for testing purposes
        string comment = "this is a comment from a lecturer";
        // string comment = io:readln("Enter a comment: ")

        json toSend = {"Lecturers": lecturers[courseCode],
                        "Information": courses[courseCode],
                        "Lecturer's Comment": comment};
        res.setJsonPayload(toSend, contentType = "application/json");
        check caller -> respond(res);
    }
}