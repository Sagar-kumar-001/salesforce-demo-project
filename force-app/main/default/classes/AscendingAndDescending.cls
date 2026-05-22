public class AscendingAndDescending {
    public static Map<String, List<Decimal>> ascDesc(Decimal num1, Decimal num2, Decimal num3) {
        // Create a list and sort it in ascending order
        List<Decimal> numbers = new List<Decimal>{num1, num2, num3};
        numbers.sort(); // Sorts in ascending order

        // Creating descending order
        List<Decimal> descList = new List<Decimal>();
        for (Integer i = numbers.size() - 1; i >= 0; i--) {
            descList.add(numbers[i]); // Manually adding elements in reverse order
        }

        // Creating a map to return both lists
        Map<String, List<Decimal>> ascDescListMap = new Map<String, List<Decimal>>();
        ascDescListMap.put('AscList', numbers);
        ascDescListMap.put('DescList', descList);

        return ascDescListMap;
    }
}