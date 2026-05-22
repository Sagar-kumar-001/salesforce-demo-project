// import { LightningElement, track } from 'lwc';
// import uploadFiles from '@salesforce/apex/FileUploadController.uploadFiles';

// // Maximum file size in bytes (200KB)
// const MAX_FILE_SIZE = 200 * 1024;

// export default class MultipleFileUpload extends LightningElement {

//     @track files = [];
//     @track uploadResults = [];
//     @track isUploadDisabled = true;
    
//     // Accepted file formats (customize as needed)
//     acceptedFormats = ['.pdf', '.png', '.jpg', '.jpeg', '.doc', '.docx', '.xls', '.xlsx', '.txt'];
    
//     handleFileChange(event) {
//         this.uploadResults = [];
//         this.files = [];
//         this.isUploadDisabled = true;
        
//         if (event.target.files.length > 0) {
//             let allFilesValid = true;
            
//             // Process each file
//             Array.from(event.target.files).forEach(file => {
//                 const fileInfo = {
//                     name: file.name,
//                     size: file.size,
//                     type: file.type,
//                     file: file
//                 };
                
//                 // Check file size
//                 if (file.size > MAX_FILE_SIZE) {
//                     fileInfo.error = 'File size exceeds 200KB limit';
//                     allFilesValid = false;
//                 }
                
//                 this.files.push(fileInfo);
//             });
            
//             // Enable upload button only if all files are valid
//             this.isUploadDisabled = !allFilesValid;
//         }
//     }
    
//     handleUpload() {
//         if (this.files.length === 0) return;
        
//         // Filter out files with errors (shouldn't happen as button is disabled)
//         const validFiles = this.files.filter(file => !file.error);
        
//         // Read files as base64 strings
//         const fileReaders = validFiles.map(file => {
//             return new Promise((resolve) => {
//                 const reader = new FileReader();
//                 reader.onload = () => {
//                     const base64 = reader.result.split(',')[1];
//                     resolve({
//                         name: file.name,
//                         content: base64,
//                         type: file.type
//                     });
//                 };
//                 reader.readAsDataURL(file.file);
//             });
//         });
        
//         // Process all files
//         Promise.all(fileReaders)
//             .then(fileData => {
//                 // Call Apex to upload files
//                 return uploadFiles({ files: fileData });
//             })
//             .then(results => {
//                 this.uploadResults = results.map((result, index) => {
//                     return {
//                         name: validFiles[index].name,
//                         success: result.isSuccess,
//                         error: result.error
//                     };
//                 });
//             })
//             .catch(error => {
//                 this.uploadResults = validFiles.map(file => {
//                     return {
//                         name: file.name,
//                         success: false,
//                         error: error.body?.message || error.message || 'Unknown error'
//                     };
//                 });
//                 console.error('Upload error:', error);
//             });
//     }
// }



import { LightningElement, api } from 'lwc';
import uploadFile from '@salesforce/apex/FileUploadController.uploadFile';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const MAX_FILE_SIZE = 200000; // 200 KB

export default class MultipleFileUpload extends LightningElement {
    @api recordId;
    selectedFiles = [];

    handleFileChange(event) {
        const files = event.target.files;
        this.selectedFiles = [];

        for (let file of files) {
            if (file.size > MAX_FILE_SIZE) {
                this.showToast('Error', `${file.name} exceeds 200 KB limit`, 'error');
            } else {
                this.selectedFiles.push(file);
            }
        }

        if (this.selectedFiles.length === 0) {
            this.showToast('Warning', 'No valid files selected', 'warning');
        }
    }

    uploadFiles() {
        if (this.selectedFiles.length === 0) {
            this.showToast('Error', 'Please select valid files first', 'error');
            return;
        }

        this.selectedFiles.forEach(file => {
            const reader = new FileReader();
            reader.onload = () => {
                let base64 = reader.result.split(',')[1];
                uploadFile({ base64Data: base64, fileName: file.name, recordId: this.recordId })
                    .then(() => {
                        this.showToast('Success', `${file.name} uploaded`, 'success');
                    })
                    .catch(error => {
                        this.showToast('Error', `Error uploading ${file.name}`, 'error');
                        console.error(error);
                    });
            };
            reader.readAsDataURL(file);
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}