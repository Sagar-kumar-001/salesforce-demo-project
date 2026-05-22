public class BatchApexDemoScheduler implements schedulable{
    public void execute(SchedulableContext sch){
        Id jobId=Database.executeBatch(new BatchApexDemo());
        System.debug(jobId);
    }
}