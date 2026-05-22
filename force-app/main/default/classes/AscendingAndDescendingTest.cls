@isTest
public class AscendingAndDescendingTest {
    @isTest
    private static void ascDescTest() {
        // Expected values
        List<Decimal> expectedAscList = new List<Decimal>{10, 20, 30};
        List<Decimal> expectedDescList = new List<Decimal>{30, 20, 10};

        // Call method
        Map<String, List<Decimal>> result = AscendingAndDescending.ascDesc(10, 20, 30);

        // Validate results
        System.assertEquals(expectedAscList, result.get('AscList'), 'Ascending order is incorrect');
        System.assertEquals(expectedDescList, result.get('DescList'), 'Descending order is incorrect');
    }
}