<%@ Page Title="Test 1" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test1.aspx.vb" Inherits="ProgrammersTest.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %></h2>
        <p>Implement a function that checks whether a positive number is a palindrome or not.</p>
        <p>A palindrome number is a number that <b>reads the same forwards and backward</b>. If you reverse the order of its digits, you get the <b>exact same number</b>.</p>
        <p>Write any number in the textbox below to check whether it is a <b>palindrome number</b>.</p>
    </main>

    <div class="row">
        <div class="col-1">
            <asp:Label runat="server" Text="Number: " />
        </div>
        <div class="col-2">
            <asp:TextBox runat="server" ID="txtNumber" placeholder="write here a number..." />
        </div>
    </div>
    <br/>
    <div class="row">
        <asp:Label runat="server" ID="lblResponse" />
    </div>


     <script type="text/javascript">


         $(document).ready(function () {
             var txtNumber = $('#<%= txtNumber.ClientID %>');

            txtNumber.on('keypress', function (event) {
                var charCode = event.which;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    event.preventDefault();
                }
            });

            txtNumber.on('input', function () {
                var currentValue = $(this).val();
                calculateNumber(currentValue);
            });

        });

        function calculateNumber(number) {
            
            var lblResponse = $('#<%= lblResponse.ClientID %>');

             if (number === "") {
                 lblResponse.text(''); 
                 return;
             }

             var reversedNumber = number.split('').reverse().join('');

             if (number === reversedNumber) {
                 lblResponse.text(number + ' is a palindrome!').css('color', 'green');
             } else {
                 lblResponse.text(number + ' is not a palindrome.').css('color', 'red');
             }
         }
     </script>
</asp:Content>

