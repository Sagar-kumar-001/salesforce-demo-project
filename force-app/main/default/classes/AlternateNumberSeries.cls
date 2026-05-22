public class AlternateNumberSeries {
    public static List<Integer> series(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=1;i<100;i+=2){
            intList.add(i);
        }
        return intList;
    }
}