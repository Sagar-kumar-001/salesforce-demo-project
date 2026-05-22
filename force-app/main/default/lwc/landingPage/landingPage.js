import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LeaveLanding extends LightningElement {
    @track showApplyComponent = false;
    @track showApproveComponent = false;
    @track showStatusComponent = false;

    get applyLeaveVariant() {
        return this.showApplyComponent ? 'brand' : 'neutral';
    }

    get approveRejectVariant() {
        return this.showApproveComponent ? 'brand' : 'neutral';
    }

    get leaveStatusVariant() {
        return this.showStatusComponent ? 'brand' : 'neutral';
    }

    showApplyLeave() {
        this.hideAll();
        this.showApplyComponent = true;
    }

    showApproveReject() {
        this.hideAll();
        this.showApproveComponent = true;
    }

    showLeaveStatus() {
        this.hideAll();
        this.showStatusComponent = true;
    }

    hideAll() {
        this.showApplyComponent = false;
        this.showApproveComponent = false;
        this.showStatusComponent = false;
    }

    handleSuccess() {
        this.hideAll();
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Leave application submitted!',
                variant: 'success'
            })
        );
    }
}