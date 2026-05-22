@isTest
public class GradeMarksAndAverageTest {
	//Test case-1
	@isTest
    private static void test1(){
        String res=GradeMarksAndAverage.marks(1,90,90,80);
        System.assertEquals('Grade-A',res);
    }
    
    //Test case-2
    @isTest
    private static void test2(){
        String res=GradeMarksAndAverage.marks(2,50,64,49);
        System.assertEquals('Grade-B',res);
    }
    
    //Test case-3
    @isTest
    private static void test3(){
        String res=GradeMarksAndAverage.marks(3,38,44,41);
        System.assertEquals('Grade-C',res);
    }
    
    //Test case-4
    @isTest
    private static void test4(){
        String res=GradeMarksAndAverage.marks(3,30,41,21);
        System.assertEquals('Grade-F',res);
    }
}