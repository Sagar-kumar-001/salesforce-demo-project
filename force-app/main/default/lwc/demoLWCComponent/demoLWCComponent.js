import { LightningElement } from 'lwc';

export default class DemoLWCComponent extends LightningElement {
    firstNumber=0;
    secondNumber=0;
    result=0;

    handleNum1(event){
        this.firstNumber=event.target.value;
    }
    handleNum2(event){
        this.secondNumber=event.target.value;
    }
    handleAdd(event){
        this.result=this.firstNumber+this.secondNumber;
    }
    handleSubtract(event){
        this.result=this.firstNumber-this.secondNumber;
    }
    handleMultiply(event){
        this.result=this.firstNumber*this.secondNumber;
    }

}