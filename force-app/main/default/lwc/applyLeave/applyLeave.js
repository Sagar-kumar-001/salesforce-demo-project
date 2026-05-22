import { LightningElement } from 'lwc';

export default class ApplyLeave extends LightningElement {
    handleSuccess() {
        this.dispatchEvent(new CustomEvent('success'));
    }

    handleCancel() {
        this.dispatchEvent(new CustomEvent('cancel'));
    }
}