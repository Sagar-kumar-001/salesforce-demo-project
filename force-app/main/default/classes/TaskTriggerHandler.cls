public class TaskTriggerHandler {
    //21.Write a trigger, only system admin user should be able to delete the task.
    public static void onlySystemAdminCanDeleteTask(List<Task> taskList){
        // Get the current user's Profile Id
        Id currentProfileId = UserInfo.getProfileId();
        
        // Query for the System Administrator profile
        Id adminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        
        for(Task t:taskList){
            if(currentProfileId!=adminProfileId){
                t.addError('You are not authorized');
            }
        }    
    }
}