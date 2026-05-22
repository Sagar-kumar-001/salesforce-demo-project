import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DemoToast extends LightningElement {
    myTitle="Toast Demo";
    showToast(){
        const event=new ShowToastEvent({
            title: 'Toast Demo Title',
            message: 'This is a new toast! Hurry!',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }
}