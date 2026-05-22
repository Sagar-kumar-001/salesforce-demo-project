@isTest
public class TaskTriggerHandlerTest {
    
    @isTest
    static void testAdminCanDeleteTask() {
        // Fetch System Administrator Profile
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];

        // Create a System Admin User
        User adminUser = new User(
            FirstName = 'Admin',
            LastName = 'User',
            Email = 'adminuser@test.com',
            Username = 'adminuser@test.com' + System.currentTimeMillis(),
            Alias = 'admin',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = adminProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert adminUser;

        // Run test as Admin User
        System.runAs(adminUser) {
            // Create Task Record as Admin (Owner is Admin)
            Task t = new Task(OwnerId = adminUser.Id, Subject = 'Admin Task', Status = 'Not Started');
            insert t;

            System.Test.startTest();
            delete t; 
            System.Test.stopTest();
        }
    }

    @isTest
    static void testNonAdminCannotDeleteTask() {
        // Fetch a Non-Admin Profile (e.g., Standard User)
        Profile nonAdminProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        // Create a Non-Admin User
        User nonAdminUser = new User(
            FirstName = 'NonAdmin',
            LastName = 'User',
            Email = 'nonadminuser@test.com',
            Username = 'nonadminuser@test.com' + System.currentTimeMillis(),
            Alias = 'nonadm',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = nonAdminProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert nonAdminUser;

        System.runAs(nonAdminUser) {
            // Create Task Record as Non-Admin (Owner is Non-Admin)
            Task t = new Task(OwnerId = nonAdminUser.Id, Subject = 'Restricted Task', Status = 'Not Started');
            insert t;

            System.Test.startTest();
            try {
                delete t;
                System.assert(false, 'Expected error was not thrown');
            } catch (DmlException e) {
                System.assert(e.getMessage().contains('You are not authorized'), 
                              'Unexpected error message: ' + e.getMessage());
            }
            System.Test.stopTest();
        }
    }
}