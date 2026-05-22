public class NumberIsEven {
    public static Integer checkNum(Integer num){
        if(Math.mod(num,2)==0){
            return 2;
        }
        else{
            return 1;
        }
    }
}