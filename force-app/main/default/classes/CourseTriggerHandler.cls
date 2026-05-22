public class CourseTriggerHandler {
    public static void updatingEnrollmentStatusOfStudents(List<Course__c> newList, Map<Id, Course__c> oldMap) {
        Set<Id> changedCourseIds = new Set<Id>();
        List<Course__c> changedCourses = new List<Course__c>();

        //Identifying courses with changed schedules
        for (Course__c newCourse : newList) {
            Course__c oldCourse = oldMap.get(newCourse.Id);
            if (newCourse.Schedule__c != oldCourse.Schedule__c) {
                changedCourseIds.add(newCourse.Id);
                changedCourses.add(newCourse);
            }
        }

        if (!changedCourseIds.isEmpty()) {
            //Get students enrolled in those courses
            List<Student__c> affectedStudents = [SELECT Id, Name, Email__c, Course__c, Enrollment_Status__c 
                                                 FROM Student__c 
                                                 WHERE Course__c IN :changedCourseIds];

            //Updating student enrollment status
            for (Student__c student : affectedStudents) {
                student.Enrollment_Status__c = 'Updated Due to Schedule Change';
            }
            update affectedStudents;

            //Passing everything to async class
            EmailNotificationAsync.sendNotificationsAsync(affectedStudents, changedCourses);
        }
    }
}