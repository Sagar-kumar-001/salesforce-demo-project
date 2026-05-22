import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    countValue=0;
    text='';
    handleSub(){
        this.countValue--;
    }
    handleAdd(){
        this.countValue++;
    }
    handleMultiply(event){
        const multiplyingVal=event.detail;
        this.countValue*=multiplyingVal;
    }
    handleClick(event){
        this.template.querySelector('[data-id="p2"]').innerHTML=event.detail;

    }

    handleClick2(event){
        const text=this.template.querySelector('[data-id="p3"]');
        this.text=text.textContent;
        // console.log(this.text);
    }
}