import { api, LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api textValue;
    handleDec(){
        this.dispatchEvent(new CustomEvent('subtract'));
    }

    handleInc(){
        this.dispatchEvent(new CustomEvent('add'));
    }

    handleMultiply(event){
        const multiplyingValue=event.target.value;
        this.dispatchEvent(new CustomEvent('multiply',{
            detail : multiplyingValue
        }))
    }

    handleClick(){
        const text=this.template.querySelector('[data-name="para"]');
        // window.alert(text.textContent);
        // console.log(text.textContent);
        this.dispatchEvent(new CustomEvent('buttonclick',{
            detail: text.textContent
        }))
    }
}