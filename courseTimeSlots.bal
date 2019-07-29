import ballerina/io;

type CourseNotFoundErrorData record{
    string courseName;
};

type CourseNotFoundError error<string, CourseNotFoundErrorData>;

// shows time slot for course
function showTimeSlot(string course ,json timeSlot) returns (any | error){
    boolean found = false;
    // Confirm if course exists
    foreach string c in timeSlot.getKeys(){
        if(c == course){
            found = true;
        }
    }
    // Return error if course not found
    if(!found){
        CourseNotFoundErrorData errorDetail = {
            courseName: course
        };
        CourseNotFoundError e = error("Error: Course not found", errorDetail);
        return e;
    }
    json result = timeSlot[course];
    if(result is json[]){
        // Display each on separate line
        foreach int i in 0..<result.length(){
            io:println(result[i]);
        }
    }else {
        io:println(result);
    }
    return result;
}

public function main(){
    json slots = {"dsp":["11:30", "5:15"], "fmm": "5:15", "svt":["5:15", "2:00"], "prg":["8:30", "11:30"]};
    //io:println(slots);
    var out = showTimeSlot("dsp", slots);
    if(out is error){
        io:println(out.reason(),"\n", "Course: ",out.detail().courseName);
    }
    
}
