<%@ Page Title="Test 2" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test2.aspx.vb" Inherits="ProgrammersTest.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %></h2>
        <p>Write some code that will accept an amount and convert it to the appropriate string representation.</p>
        <p>
            Example: Convert 2523.04 to "Two thousand five hundred twenty-three and 04/100 dollars"
        </p>
    </main>

    <div class="row">
        <div class="col-1">
            <asp:Label runat="server" Text="Amount: " />
        </div>
        <div class="col-2">
            <asp:TextBox runat="server" ID="txtNumber" placeholder="write here an amount..." />
        </div>
    </div>
    <br />
    <div class="row">
        <asp:Label runat="server" ID="lblResponse" />
    </div>


    <script type="text/javascript">

        $(document).ready(function () {
            var txtNumber = $('#<%= txtNumber.ClientID %>');

            txtNumber.on('keypress', function (event) {
                var charCode = event.which;
                var currentValue = $(this).val();

                // Teclas de controle 
                if (charCode < 32) {
                    return;
                }

                if (charCode === 46) {
                    if (currentValue.includes(',') || currentValue.includes('.')) {
                        event.preventDefault();
                    }
                    return;
                }

                if (charCode < 48 || charCode > 57) {
                    event.preventDefault();
                }
            });

            txtNumber.on('input', function () {
                var currentValue = $(this).val();
                calculateNumber(currentValue);
            });
        });

        function calculateNumber(number) {

            var response = "";
            var responseDollars = "";
            var responseCents = "";

            var lblResponse = $('#<%= lblResponse.ClientID %>');

            if (number === "") {
                lblResponse.text('');
                return;
            }

            var value = number.split('.')[0];
            var cents = number.split('.')[1];

            if (value && value !== "") responseDollars += convertNumberToWords(value);
            if (cents && cents !== "") responseCents += convertCentsIntoFraction(cents);

            if (responseDollars !== "" && responseCents !== "") response = responseDollars + " and " + responseCents;
            else if (responseDollars && responseDollars !== "") response = responseDollars;
            else response = responseCents;

            response += " dollars."
            lblResponse.text(response).css('font-weight', 'bold');
        }

        function convertCentsIntoFraction(value) {
            var num = new Number("0." + value);
            const cents = num.toFixed(2) * 100;

            var resp = cents;

            if (cents === 0) {
                return "";
            } else {
                if (cents >= 0 && cents < 10) resp =  '0' + cents;
                return resp + "/100"

            } 
        }


        function convertNumberToWords(num){

            const units = [
                "", "", "", "hundred", "thousand", "thousand", "thousand", "million", "million", "million", "billion", "billion", "billion"
            ]


            // --- Validação da Entrada ---
            const numeroInteiro = parseInt(num, 10);
            if (isNaN(numeroInteiro) || numeroInteiro < 0 || numeroInteiro > 999999999999) {
                return "Please provide a number lower than one trillion";
            }
            var numToString = numeroInteiro.toString();

            var k = 0;
            var array = "";

            for (let i = numToString.length - 1; i >= 0; i--) {
                if (k == 3) {
                    array = "." + array;
                    k = 0;
                }
                const char = numToString[i];
                array = char + array;
                k++;
            }


            var places = array.split('.');
            console.log(places);




        }
      
        function figureOutUpTo99(num) {

            const units = [
                "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
            ];

            const teens = [
                "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
            ];

            const tens = [
                "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
            ];


            // --- Validação da Entrada ---
            const numeroInteiro = parseInt(num, 10);
            if (isNaN(numeroInteiro) || numeroInteiro < 0 || numeroInteiro > 99) {
                return "Please provide a number between 0 and 99.";
            }

            // --- Lógica de Conversão ---

            // Caso 1: Número é zero
            if (numeroInteiro === 0) {
                return "zero";
            }

            // Caso 2: Unidades (1-9)
            if (numeroInteiro < 10) {
                return units[numeroInteiro];
            }

            // Caso 3: Casos especiais (10-19)
            if (numeroInteiro < 20) {
                // O número 10 corresponde ao índice 0, 11 ao 1, etc. Por isso subtraímos 10.
                return teens[numeroInteiro - 10];
            }

            // Caso 4: Dezenas e números compostos (20-99)
            // Pega o dígito da dezena (ex: para 57, pega o 5)
            const dezena = Math.floor(numeroInteiro / 10);
            // Pega o dígito da unidade (ex: para 57, pega o 7)
            const unidade = numeroInteiro % 10;

            // Constrói a resposta
            const palavraDezena = tens[dezena];
            const palavraUnidade = units[unidade];

            if (unidade === 0) {
                // Se for um número redondo (20, 30, etc.), retorna apenas a palavra da dezena.
                return palavraDezena;
            } else {
                // Se for um número composto (21, 57, etc.), combina com um hífen.
                return `${palavraDezena}-${palavraUnidade}`;
            }
        }


    </script>

</asp:Content>
