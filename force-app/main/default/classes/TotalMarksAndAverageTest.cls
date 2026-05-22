@isTest
public class TotalMarksAndAverageTest {
    //Test case 1 for Normal values
	@isTest
    public static void totalMarksTest1(){
        //Roll No.-1,Phy Marks=80,Chem Marks=90,Maths Marks=90
        Decimal result=TotalMarksAndAverage.totalMarks(1,80,90,90);
        System.assertEquals(260,result);
    }
    
    //Test case 2,For Any O values
    @isTest
    public static void totalMarksTest2(){
        //Roll No.-2,Phy Marks=0,Chem Marks=90,Maths Marks=90
        Decimal result=TotalMarksAndAverage.totalMarks(1,80,90,90);
        System.assertEquals(260,result);
    }
    
    //Test case 3 for average Marks normal values
    @isTest
    public static void avgMarksTest1(){
        //Roll No.-1,Phy Marks=80,Chem Marks=90,Maths Marks=90
        Decimal result=TotalMarksAndAverage.avgMarks(1,80,90,90);
        System.assertEquals(86.66666,result);
    }
    
    
}