import ballerina/http;
import ballerina/io;

map<json> courseDetails = {"DSP620S": {"abstract": "interesting stuff"}};
map<json> lectureCourse = {"DSP620S": {"name":"Mr JJ", "age":22}};

@http:ServiceConfig {
    basePath: "/lecturer-management"
}

service lectureService on new http:Listener(9092) {
    
    @http:ResourceConfig{
        path: "/remarks",
        methods: ["POST"]
    }

    resource function getInfo(http:Caller caller, http:Request request) returns error? {
        http:Response res =new;
        json getInfo = check request.getJsonPayload();
        string courseCode = check string.convert(getInfo["courseID"]);
        json lectInfo = lectureCourse[courseCode];
        json courseInfo = courseDetails[courseCode];
        // instructions require manual input but we automate for testing purposes
        string comment = "this is a comment from a lecturer";
        // string comment = io:readln("Enter a comment: ")
        json output = {"lecture information": lectInfo,
                        "course information": courseInfo,
                        "comment from lecturer": comment};
        res.setJsonPayload(output, contentType = "application/json");
        var x = caller -> respond(res);
    }
}