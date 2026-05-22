public class EmployeeTriggerHandler {
	//29.Create a custom object Employee with fields Name(text), Active(checkbox) and lookup relationship with Account. Now create some 
	//records for the Employee object. Employee records can not be deleted if the active field of the employee is true.
    /*public static void activeEmployeeCantBeDeleted(List<Employee__c> empList){
        for(Employee__c emp:empList){
            if(emp.Active__c==true){
                emp.addError('Active Employee cant be deleted');
            }
        }
    }*/
    
    //31.Create a custom field "Deleted Employee Count" on Account object. When an employee record is deleted then update the deleted 
    //employee count on related Account records.
    public static void deletedEmployeeCountUpdationOnAccount(List<Employee__c> empList){
        Set<Id> accId=new Set<Id>();
        List<Account> accList=new List<Account>();
        for(Employee__c emp:empList){
            if(emp.Account__c!=Null){
                accId.add(emp.Account__c);
            }
        }
        Map<Id,Account> accIdToAccMap=new Map<Id,Account>([Select Id,Name,Deleted_Employee_Count__c from Account where Id IN :accId]);
        for(Employee__c emp:empList){
            if(emp.Account__c!=Null && accIdToAccMap.containsKey(emp.Account__c)){
                Account acc=new Account();
                acc.Id=emp.Account__c;
                acc.Deleted_Employee_Count__c=(accIdToAccMap.get(emp.Account__c).Deleted_Employee_Count__c ==null ? 
                                               0: accIdToAccMap.get(emp.Account__c).Deleted_Employee_Count__c)+1;
                accList.add(acc);
            }
        }
        update accList;
    }
    
    //32.Undelete employee record and set Active field as true. Also update the deleted employee count in Account Record.
    public static void undeleteEmpRecordAndUpdateCountOfDeletedEmployeeOnAccount(List<Employee__c> empList){
        Set<Id> accId=new Set<Id>();
        for(Employee__c emp:empList){
            accId.add(emp.Account__c);
        }
        Map<Id,Account> accIdToAccMap=new Map<Id,Account>([Select Id,Name,Deleted_Employee_Count__c from Account where Id IN:accId]);
        List<Account> accList=new List<Account>();
        for(Employee__c emp:empList){
            if(emp.Account__c!=null && accIdToAccMap.containsKey(emp.Account__c)){
                Account acc=new Account();
                acc.Id=emp.Account__c;
                acc.Deleted_Employee_Count__c=(accIdToAccMap.get(emp.Account__c).Deleted_Employee_Count__c ==null ? 
                                               0: accIdToAccMap.get(emp.Account__c).Deleted_Employee_Count__c)-1;
                accList.add(acc);
            }
        }
        update accList;
    }
    
    //46.Create two custom objects named Company and Employee. The employee has a lookup relationship with the company. Create two fields 
    //Max Salary (currency) and Min Salary (currency) on Company. Now show the Min & Max salary of Employee records on the parent company record.
    public static void updateMaxMinSalaryFieldOnCompany(List<Employee__c> empList){
        Set<Id> comIdSet=new Set<Id>();
        for(Employee__c emp:empList){
            comIdSet.add(emp.Company__c);
        }
        List<AggregateResult> result=[Select MAX(Salary__c) maxSalary,MIN(Salary__c) minSalary,Company__c compId from Employee__c 
                                      where Company__c IN:comIdSet group by Company__c];
        List<Company__c> compList=new List<Company__c>();
        for(AggregateResult agr:result){
            Company__c c=new Company__c();
            c.Id=(Id)agr.get('compId');
            c.Max_Salary__c=(Decimal)agr.get('maxSalary');
            c.Min_Salary__c=(Decimal)agr.get('minSalary');
            compList.add(c);
        }
        if(!compList.isEmpty()){
            update compList;
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}