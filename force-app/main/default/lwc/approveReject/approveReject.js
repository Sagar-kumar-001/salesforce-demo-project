import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getPendingLeaves from '@salesforce/apex/LeaveController.getPendingLeaves';
import updateLeaveStatus from '@salesforce/apex/LeaveController.updateLeaveStatus';

export default class ApproveReject extends LightningElement {
    @track pendingLeavesData = [];
    @track wiredPendingLeavesResult;
    @track isLoading = true;
    
    columns = [
        { label: 'Employee', fieldName: 'employeeName', type: 'text' },
        { label: 'End Date', fieldName: 'End_Date__c', type: 'date' },
        { label: 'Leave Type', fieldName: 'Leave_Type__c', type: 'text' },
        { label: 'Reason', fieldName: 'Reason__c', type: 'text' },
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'Approve', name: 'approve' },
                    { label: 'Reject', name: 'reject' }
                ]
            }
        }
    ];

    @wire(getPendingLeaves)
    wiredPendingLeaves(result) {
        this.wiredPendingLeavesResult = result;
        if (result.data) {
            this.pendingLeavesData = result.data.map(leave => ({
                ...leave,
                employeeName: leave.Employees__r?.Name || 'N/A'
            }));
            this.isLoading = false;
        } else if (result.error) {
            this.showToast('Error', 'Error loading leave requests', 'error');
            this.isLoading = false;
        }
    }

    async handleRowAction(event) {
        this.isLoading = true;
        const action = event.detail.action;
        const row = event.detail.row;
        
        try {
            // Update status to 'Approved' or 'Rejected' (capitalized)
            await updateLeaveStatus({ 
                leaveId: row.Id, 
                status: action.name === 'approve' ? 'Approved' : 'Rejected'
            });
            
            this.showToast('Success', `Leave ${action.name}d successfully`, 'success');
            
            // Refresh the data
            await refreshApex(this.wiredPendingLeavesResult);
            
            // Update local data to remove the processed leave
            this.pendingLeavesData = this.pendingLeavesData.filter(
                item => item.Id !== row.Id
            );
            
        } catch (error) {
            console.error('Error updating status:', error);
            this.showToast('Error', 
                error.body?.message || 'Error processing request', 
                'error');
        } finally {
            this.isLoading = false;
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}