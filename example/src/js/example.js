import { CapLinking } from 'capacitor-linking';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapLinking.echo({ value: inputValue })
}
