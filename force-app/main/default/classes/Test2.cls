public class Test2 {
    public void percentage(Integer percent){
        if(percent>=90){
            System.debug('Grade-A');
        }
        else if(percent >=80){
            System.debug('Grade-B');
        }
        else if(percent>=60){
            System.debug('Grade-C');
        }
        else if(percent>=40){
            System.debug('Grade-D');
        }
        else{
            System.debug('Grade-F');
        }
    }
    
    
    public static void testingMap(){
        Map<Id,Account> idToAccountMap=new Map<Id,Account>([Select Name,AccountNumber,Phone from Account limit 5]);
        for(Id id:idToAccountMap.keySet()){
            System.debug('Key->'+id+' Value->'+idToAccountMap.get(id).Phone);
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}