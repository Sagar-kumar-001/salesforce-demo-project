public class TotalMarksAndAverage {
    static Decimal totalMarks;
    public static Decimal totalMarks(Integer rollNo,Decimal physicsMarks,Decimal chemMarks,Decimal mathsMarks){
        totalMarks=physicsMarks+chemMarks+mathsMarks;
        System.debug('Roll Number:'+rollNo);
        return totalMarks;
    }
    public static Decimal avgMarks(Integer rollNo,Decimal physicsMarks,Decimal chemMarks,Decimal mathsMarks){
        Decimal averageMarks=totalMarks/3;
        System.debug('Roll Number:'+rollNo);
        System.debug(averageMarks);
        return averageMarks;
    }
    
}