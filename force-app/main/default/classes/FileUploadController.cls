// public with sharing class FileUploadController {
    
//     @AuraEnabled
//     public static List<UploadResult> uploadFiles(List<FileData> files) {
//         List<UploadResult> results = new List<UploadResult>();
//         List<ContentVersion> contentVersions = new List<ContentVersion>();
        
//         for (FileData file : files) {
//             UploadResult result = new UploadResult();
//             result.name = file.name;
            
//             try {
//                 // Create ContentVersion record
//                 ContentVersion cv = new ContentVersion();
//                 cv.Title = file.name;
//                 cv.PathOnClient = file.name;
//                 cv.VersionData = EncodingUtil.base64Decode(file.content);
//                 cv.IsMajorVersion = true;
                
//                 contentVersions.add(cv);
//                 result.isSuccess = true;
//             } catch (Exception e) {
//                 result.isSuccess = false;
//                 result.error = e.getMessage();
//             }
            
//             results.add(result);
//         }
        
//         // Insert all content versions in one DML operation
//         if (!contentVersions.isEmpty()) {
//             Database.SaveResult[] srList = Database.insert(contentVersions, false);
            
//             // Update results based on save results
//             for (Integer i = 0; i < srList.size(); i++) {
//                 if (!srList[i].isSuccess()) {
//                     results[i].isSuccess = false;
//                     results[i].error = '';
//                     for (Database.Error err : srList[i].getErrors()) {
//                         results[i].error += err.getMessage() + ' ';
//                     }
//                 }
//             }
//         }
        
//         return results;
//     }
    
//     // Inner class to pass file data from LWC to Apex
//     public class FileData {
//         @AuraEnabled public String name { get; set; }
//         @AuraEnabled public String content { get; set; }
//         @AuraEnabled public String type { get; set; }
//     }
    
//     // Inner class to return upload results to LWC
//     public class UploadResult {
//         @AuraEnabled public String name { get; set; }
//         @AuraEnabled public Boolean isSuccess { get; set; }
//         @AuraEnabled public String error { get; set; }
//     }
// }


public with sharing class FileUploadController {
    @AuraEnabled
    public static String uploadFile(String base64Data, String fileName, String recordId) {
        try {
            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = fileName;
            cv.VersionData = EncodingUtil.base64Decode(base64Data);
            cv.FirstPublishLocationId = recordId;
            insert cv;

            return 'Success';
        } catch (Exception e) {
            throw new AuraHandledException('Error uploading file: ' + e.getMessage());
        }
    }
}