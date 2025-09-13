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

            response === "One  " || response === "Zero" ? response += " dollar." : response += " dollars.";
            lblResponse.text(response).css('font-weight', 'bold');
        }

        function convertCentsIntoFraction(value) {
            var num = new Number("0." + value);
            const cents = num.toFixed(2) * 100;

            var resp = cents;

            if (cents === 0) {
                return "";
            } else {
                if (cents >= 0 && cents < 10) resp = '0' + cents;
                return resp + "/100"

            }
        }

        function convertNumberToWords(num) {

            const integerNumber = parseInt(num, 10);
            if (isNaN(integerNumber) || integerNumber < 0 || integerNumber > 999999999999) {
                return "Please provide a number lower than one trillion";
            }
            if (integerNumber == 0) {
                return "Zero";
            }
            var numToString = integerNumber.toString();

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
            var p = 0;

            var fullResp = "";

            for (let i = places.length; i >= 1; i--) {
                fullResp += createFullNumber(places[p], i);
                p++;
            }

            return firstLetterUpper(fullResp);
        }

        function createFullNumber(elem, index) {
            const units = [
                "", "", "thousand", "million", "billion"
            ]

            return figureOutUpTo99(elem) + " " + units[index] + " ";
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


            // Validation
            const integerNum = parseInt(num, 10);
            if (isNaN(integerNum) || integerNum < 0 || integerNum > 999) {
                return "Please provide a number between 0 and 999.";
            }

            if (integerNum === 0) {
                return "";
            }

            if (integerNum < 10) {
                return units[integerNum];
            }

            if (integerNum < 20) {
                return teens[integerNum - 10];
            }

            var hundreds = Math.floor(new Number(num / 100));
            const dozens = Math.floor(new Number(num % 100) / 10);
            const unit = Math.floor(new Number(num % 100) % 10);

            //build the response
            const wordHundreds = units[hundreds] + (units[hundreds] !== "" ? " hundred" : "");
            const wordDozens = tens[dozens];
            const wordUnit = units[unit];

            if (unit === 0) return `${wordHundreds} ${wordDozens}`;
            else return `${wordHundreds} ${wordDozens}-${wordUnit}`;
        }


        function firstLetterUpper(str) {

            if (!str) {
                return "";
            }

            const firstChar = str.charAt(0).toUpperCase();
            const restOfString = str.slice(1).toLowerCase();
            return firstChar + restOfString;
        }

    </script>

</asp:Content>
