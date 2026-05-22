@isTest
public class MarriageEligibilityTest {

    //Test case 1
    @isTest
    private static void eligibilityTest(){
        String res=MarriageEligibility.checkEligibility('unmarried', 'male', 25);
        System.assertEquals('Eligible for marriage',res);
    }
    
    //Test case 2
    @isTest
    private static void eligibilityTest2(){
        String res=MarriageEligibility.checkEligibility('married', 'male', 25);
        System.assertEquals('Not Eligible for marriage',res);
    }
    
    //Test case 3
    @isTest
    private static void eligibilityTest3(){
        String res=MarriageEligibility.checkEligibility('unmarried', 'female', 25);
        System.assertEquals('Eligible for marriage',res);
    }
    
    //Test case 4
    @isTest
    private static void eligibilityTest4(){
        String res=MarriageEligibility.checkEligibility('unmarried', 'male', 13);
        System.assertEquals('Not Eligible for marriage',res);
    }
}