public class GradeMarksAndAverage {
	static Decimal totalMarks,averageMarks;
    
    public static String marks(Integer rollNo,Decimal physicsMarks,Decimal chemMarks,Decimal mathsMarks){
        totalMarks=physicsMarks+chemMarks+mathsMarks;
        averageMarks=totalMarks/3;
        System.debug('Roll Number:'+rollNo);
        System.debug('Total marks of 3 subjects:'+totalMarks);
        System.debug('Average marks of 3 subjects:'+averageMarks);
        if(averageMarks>60){
            return 'Grade-A';
        }
        else if(averageMarks>=50){
            return 'Grade-B';
        }
        else if(averageMarks>=40){
            return 'Grade-C';
        }
        else{
            return 'Grade-F';
        }
    }
}