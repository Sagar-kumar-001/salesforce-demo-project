public class EmailNotificationAsync implements Queueable {
    private List<Student__c> students;
    private List<Course__c> courses;

    public EmailNotificationAsync(List<Student__c> students, List<Course__c> courses) {
        this.students = students;
        this.courses = courses;
    }

    public void execute(QueueableContext context) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        // Create a map to find course by Id for lookup
        Map<Id, Course__c> courseMap = new Map<Id, Course__c>();
        for (Course__c course : courses) {
            courseMap.put(course.Id, course);
        }

        Set<String> instructorEmailsSent = new Set<String>();

        // Loop through students and send emails
        for (Student__c student : students) {
            Course__c course = courseMap.get(student.Course__c);

            // Email to student
            Messaging.SingleEmailMessage studentEmail = new Messaging.SingleEmailMessage();
            studentEmail.setToAddresses(new String[] { student.Email__c });
            studentEmail.setSubject('Course Schedule Updated');
            studentEmail.setPlainTextBody('Hi ' + student.Name + ',\n\nThe schedule for your course "' +
                                          course.Name + '" has been updated. Please check the latest schedule.');
            emails.add(studentEmail);

            // Email to instructor (send only one per instructor per course)
            if (!instructorEmailsSent.contains(course.Instructor_Email__c)) {
                Messaging.SingleEmailMessage instructorEmail = new Messaging.SingleEmailMessage();
                instructorEmail.setToAddresses(new String[] { course.Instructor_Email__c });
                instructorEmail.setSubject('Student Enrollment Affected by Schedule Change');
                instructorEmail.setPlainTextBody('The schedule for your course "' + course.Name +
                                                 '" has changed. Students have been notified accordingly.');
                emails.add(instructorEmail);
                instructorEmailsSent.add(course.Instructor_Email__c);
            }
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails, false);
        }
    }

    public static void sendNotificationsAsync(List<Student__c> students, List<Course__c> courses) {
        System.enqueueJob(new EmailNotificationAsync(students, courses));
    }
}