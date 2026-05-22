import { LightningElement, track } from 'lwc';

export default class IfTrueIfFalseTemplateRendering extends LightningElement {
    @track onClickButtonLabel="Show";
    visibility=false;
    handleClick(){
        if(this.onClickButtonLabel==="Show"){
            this.onClickButtonLabel="Hide";
            this.visibility=true;
        }
        else if(this.onClickButtonLabel==="Hide"){
            this.onClickButtonLabel="Show";
            this.visibility=false;
        }
    }
}