//
//  API.h
//  studentRegistery
//
//  Created by macmini on 1/31/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#ifndef API_h
#define API_h

//http://14.139.82.34/ttapi
//http://120.138.10.249/timeTable

//#define loginAPI @"http://14.139.82.34/ttapi/api/Attendence/getloging?Mobilenumber="
//
//#define getFacultySchedule @"http://14.139.82.34/ttapi/api/Attendence/getSessionsinfo?facultyid="
//
//#define getAttendanceData @"http://14.139.82.34/ttapi/api/Attendence/getstudentinfo?TRowid="
//
//#define submitAPI @"http://14.139.82.34/ttapi/api/Attendence/postAttendance"
//
//#define getPrevsAttendanceData @"http://14.139.82.34/ttapi/api/Attendence/getAttendance?TRowid="
//
//#define editAttendance @"http://14.139.82.34/ttapi/api/Attendence/UpdateSingleAttendance?facultyid="
//
//#define getScheduleTable @"http://14.139.82.34/ttapi/api/Attendence/getTimetable?facultyId="
//
//#define getStudentSearchResult @"http://14.139.82.34/ttapi/api/Attendence/getAttendanceByhtno?Htno="


#define loginAPI @"http://120.138.10.249/tt/api/Emp/CheckLogindetails"

#define getFacultySchedule @"http://120.138.10.249/tt/api/Emp/getSessionsinfo?EmpId="

#define getAttendanceData @"http://120.138.10.249/tt/api/Emp/getstudentinfo?TRowid="

#define submitAPI @"http://120.138.10.249/tt/api/Emp/postAttendance"

#define getPrevsAttendanceData @"http://120.138.10.249/tt/api/Emp/getAttendance?TRowid="

#define editAttendance @"http://120.138.10.249/tt/api/Emp/UpdateSingleAttendance?EmpId="

#define getScheduleTable @"http://120.138.10.249/tt/api/Emp/getCollegeTimetable?EmpId="

#define getStudentSearchResult @"http://120.138.10.249/tt/api/Emp/getAttendanceByhtno?Htno="

#endif /* API_h */
