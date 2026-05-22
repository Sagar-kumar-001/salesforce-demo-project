public class NumIsOdd {
    public static Integer checkNum(Integer num){
        if(Math.mod(num,2)==1){
            return 2;
        }
        else{
            return 1;
        }
    }
}