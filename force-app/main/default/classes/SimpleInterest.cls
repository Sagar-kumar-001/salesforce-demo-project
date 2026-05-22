public class SimpleInterest {
    public static Decimal getSimpleInterest(Decimal p,Decimal r,Decimal t){
        Decimal simpleInterest = (p * r * t)/100;
        return simpleInterest;
    }
}