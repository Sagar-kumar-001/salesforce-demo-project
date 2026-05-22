@isTest
public class CourseTriggerHandlerTest {
    @isTest
    static void testCourseScheduleChange() {
        Course__c course = new Course__c(Name='MCA', Schedule__c=DateTime.now().addDays(1),
                                         Instructor_Email__c='sraj20211@gmail.com');
        insert course;

        Student__c student = new Student__c(Name='Sagar', Email__c='shekhar234016@gmail.com',
                                            Course__c=course.Id, Enrollment_Status__c='Enrolled');
        insert student;

        System.Test.startTest();
        course.Schedule__c = DateTime.now().addDays(2);
        update course;
        System.Test.stopTest();

        Student__c updatedStudent = [SELECT Enrollment_Status__c FROM Student__c WHERE Id = :student.Id];
        System.assertEquals('Updated Due to Schedule Change', updatedStudent.Enrollment_Status__c);
    }
}