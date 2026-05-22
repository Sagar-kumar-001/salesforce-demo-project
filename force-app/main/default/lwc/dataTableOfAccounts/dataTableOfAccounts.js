import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import deleteAccounts from '@salesforce/apex/AccountController.deleteAccounts';
import updateAccounts from '@salesforce/apex/AccountController.updateAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class AccountDatatableTask extends LightningElement {
    @track columns = [
        { label: 'Name', fieldName: 'Name', editable:true },
        { label: 'Industry', fieldName: 'Industry', editable:true },
        { label: 'Phone', fieldName: 'Phone', editable:true },
        { label: 'Type', fieldName: 'Type', editable:true }
    ];

    @track selectedIds = [];
    @track data = [];
    wiredResult;
    @track draftValues=[];

    @wire(getAccounts)
    wiredAccounts(result) {
        this.wiredResult = result;
        if (result.data) {
            this.data = result.data;
        } else if (result.error) {
            this.showToast('Error', result.error.body.message, 'error');
        }
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedIds = selectedRows.map(row => row.Id);
    }

    handleDelete() {
        if (this.selectedIds.length === 0) {
            this.showToast('Warning', 'Please select at least one record to delete.', 'warning');
            return;
        }

        deleteAccounts({ accountIds: this.selectedIds })
            .then(() => {
                this.showToast('Success', 'Selected account(s) deleted.', 'success');
                this.selectedIds = [];
                return refreshApex(this.wiredResult);
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
    

    handleSave(event){
        this.draftValues=event.detail.draftValues;
        updateAccounts({ accounts: this.draftValues })
        .then(() => {
            this.showToast('Success', 'Records updated successfully', 'success');
            this.draftValues = [];
            return refreshApex(this.wiredResult);
        })
        .catch(error => {
            this.showToast('Error saving data', error.body.message, 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}