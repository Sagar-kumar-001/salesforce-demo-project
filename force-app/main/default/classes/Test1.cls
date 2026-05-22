public class Test1 {
    public static void testing1(){
        Set<Integer> num=new Set<Integer>{1,2,3,4,5,6,7,8,9,10};
        List<Integer> numList=new List<Integer>();
        numList.addAll(num);
            for(Integer i=0;i<numList.size();i++){
                System.debug(numList[i]);
            }
        
        
    }
}