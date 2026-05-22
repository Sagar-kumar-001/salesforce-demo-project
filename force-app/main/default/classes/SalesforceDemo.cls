public class SalesforceDemo {
    public enum color {
        RED,GREEN,BLUE,BLACK,ORANGE
            }
    public static void dispalyName(){
        List<color> colList = color.values();
        System.debug(colList); // (RED, GREEN, BLUE, BLACK, ORANGE)
        System.debug(color.BLUE.ordinal()); // 2--> position of BLUE in enum
        System.debug(color.ORANGE.name()); // return ORANGE as string
        System.debug('ORANGE'.equals(color.ORANGE)); // true
        color blueColor = color.valueOf('BLUE');
        System.debug(blueColor); // BLUE
    }
}