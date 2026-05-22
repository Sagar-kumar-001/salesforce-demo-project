@isTest
public class AlternateNumberSeriesTest {
    
    public static List<Integer> existingSeries(){
        List<Integer> integerList=new List<Integer>();
    	for(Integer i=1;i<100;i+=2){
    		integerList.add(i);
     	}
        return integerList;
    }
	//Test Case 
	@isTest
    private static void test1(){
        List<Integer> resList=AlternateNumberSeries.series();
        List<Integer> expectedList=existingSeries();
        System.assertEquals(expectedList,resList);
    }
}