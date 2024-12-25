import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["firstPlayerSelect", "secondPlayerSelect"]

    currentFirstPlayer = null;
    currentSecondPlayer = null;

    connect() {
        this.setDefaultValues();
        this.updateDisabledOption();
    }

    setDefaultValues() {
        this.currentFirstPlayer = this.firstPlayerSelectTarget.options[0].value
        this.currentSecondPlayer = this.secondPlayerSelectTarget.options[1].value

        this.firstPlayerSelectTarget.value = this.currentFirstPlayer;
        this.secondPlayerSelectTarget.value = this.currentSecondPlayer;
    }

    updateDisabledOption() {
        Array.from(this.firstPlayerSelectTarget.options).forEach(e => e.disabled = false);
        Array.from(this.secondPlayerSelectTarget.options).forEach(e => e.disabled = false);

        this.secondPlayerSelectTarget.options[this.firstPlayerSelectTarget.selectedIndex].disabled = true;
        this.firstPlayerSelectTarget.options[this.secondPlayerSelectTarget.selectedIndex].disabled = true;
    }
}
