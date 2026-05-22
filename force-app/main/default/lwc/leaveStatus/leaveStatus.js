import { LightningElement, wire, track } from 'lwc';
import getEmployees from '@salesforce/apex/LeaveController.getEmployees';
import getLeaveHistory from '@salesforce/apex/LeaveController.getLeaveHistory';

export default class LeaveStatus extends LightningElement {
    @track employeeOptions = [];
    @track selectedEmployeeId;
    @track leaveHistory = [];

    columns = [
        { label: 'End Date', fieldName: 'End_Date__c', type: 'date' },
        { label: 'Leave Type', fieldName: 'Leave_Type__c' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Days Requested', fieldName: 'Days_Requested__c', type: 'number' }
    ];

    @wire(getEmployees)
    wiredEmployees({ data, error }) {
        if (data) {
            this.employeeOptions = data.map(emp => ({
                label: emp.Name,
                value: emp.Id
            }));
        } else if (error) {
            console.error('Error loading employees', error);
        }
    }

    handleEmployeeChange(event) {
        this.selectedEmployeeId = event.detail.value;
        getLeaveHistory({ employeeId: this.selectedEmployeeId })
            .then(result => {
                this.leaveHistory = result;
            })
            .catch(error => {
                console.error('Error loading leave history', error);
            });
    }

    handleBack() {
        this.dispatchEvent(new CustomEvent('back'));
    }
}