<%@ Page Title="Number to Words Conversion" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NumberToWords.aspx.vb" Inherits="ProgrammersTest.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-maskmoney/3.0.2/jquery.maskMoney.min.js"></script>

    <main aria-labelledby="title" class="container my-4">
        <h2 id="title" class="mb-3"><%: Title %></h2>

        <section class="mb-4">
            <p>
                Enter a numeric amount to convert it into its full string representation in dollars.
            </p>
            <p>
                <strong>Example:</strong> <code>2523.04</code> → 
            <em>"Two thousand five hundred twenty-three and 04/100 dollars"</em>
            </p>
        </section>

        <section class="form-area">
            <div class="row mb-3">
                <div class="col-2">
                    <asp:Label runat="server"
                        AssociatedControlID="txtNumber"
                        Text="Value:"
                        CssClass="form-label fw-bold" />
                </div>
                <div class="col-4">
                    <asp:TextBox runat="server"
                        ID="txtNumber"
                        placeholder="Write here a value..."
                        MaxLength="21"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="row">
                <div class="col-6">
                    <asp:Label runat="server"
                        ID="lblResponse"
                        CssClass="result-label fw-semibold" />
                </div>
            </div>
            
        </section>
    </main>

    <script type="text/javascript">

        $(document).ready(function () {
            var txtNumber = $('#<%= txtNumber.ClientID %>');

            txtNumber.maskMoney({
                prefix: '$ ',            
                thousands: ',',          
                decimal: '.',            
                allowZero: false,         
                affixesStay: true,       
            });

            txtNumber.on('keyup', function (event) {
                var unmaskedValue = $(this).maskMoney('unmasked')[0]; 
                calculateNumber(unmaskedValue);
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

            var value = Math.floor(number);
            var cents = Math.round((number - value) * 100); 

            if (value && value !== "") responseDollars += convertNumberToWords(value);
            if (cents && cents !== "") responseCents += convertCentsIntoFraction(cents);

            if (!responseDollars.includes("Please") && responseDollars !== "" && responseCents !== "") response = responseDollars + " and " + responseCents;
            else if (responseDollars && responseDollars !== "") response = responseDollars;
            else response = responseCents;

            if (response.trim() != "") {
                response === "One  " || response === "Zero" ? response += " dollar." : response += " dollars.";
                lblResponse.text(firstLetterUpper(response)).css('font-weight', 'bold');
            }
            else {
                lblResponse.text("");
            }
            
        }

        function convertCentsIntoFraction(value) {
            if (value === 0) {
                return "";
            } else {
                if (value >= 0 && value < 10) return '0' + value + '/100';
                return value + "/100"
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

            return fullResp;
        }

        function createFullNumber(elem, index) {
            const units = [
                "", "", "thousand", "million", "billion"
            ]
            return figureOutUpTo999(elem) + " " + units[index] + " ";
        }

        function figureOutUpTo999(num) {

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
            var unit = Math.floor(new Number(num % 100) % 10);

            
            const wordHundreds = units[hundreds] + (units[hundreds] !== "" ? " hundred" : "");
            var wordDozens = tens[dozens];
            var wordUnit = units[unit];

           
            //adjust 11-19 
            if (dozens == 1) {
                wordDozens = teens[unit];
                unit = 0;
            }
          
            if (unit === 0) return `${wordHundreds} ${wordDozens}`;
            else {
                if (wordDozens != "") return `${wordHundreds} ${wordDozens}-${wordUnit}`;
                else return `${wordHundreds}-${wordUnit}`;
            } 
        }


        function firstLetterUpper(str) {
            if (!str) {
                return "";
            }
            str = str.trim();
            const firstChar = str.charAt(0).toUpperCase();
            const restOfString = str.slice(1).toLowerCase();
            return firstChar + restOfString;
        }

    </script>

</asp:Content>
