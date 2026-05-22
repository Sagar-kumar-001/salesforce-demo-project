import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    firstNumber=0;
    secondNumber=0;
    result=0;

    handleNum1(event){
        this.firstNumber=parseFloat(event.target.value);
    }
    handleNum2(event){
        this.secondNumber=parseFloat(event.target.value);
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