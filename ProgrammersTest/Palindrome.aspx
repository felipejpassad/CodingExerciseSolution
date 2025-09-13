<%@ Page Title="Palindrome Checker" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Palindrome.aspx.vb" Inherits="ProgrammersTest.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %></h2>

        <section>
            <p>
                This page allows you to check whether a given positive number is a 
            <strong>palindrome</strong>.
            </p>
            <p>
                A palindrome is a number that <em>reads the same forwards and backwards</em>.  
            Example: <code>121</code> → Palindrome, while <code>123</code> → Not a palindrome.
            </p>
        </section>

        <section class="input-area">
            <div class="row">
                <div class="col-1">
                    <asp:Label runat="server" AssociatedControlID="txtNumber" Text="Number:" />
                </div>
                <div class="col-2">
                    <asp:TextBox
                        runat="server"
                        ID="txtNumber"
                        CssClass="form-control"
                        placeholder="Type a positive number..." />
                </div>
                <div class="col-2">
                    <asp:Button
                        runat="server"
                        ID="btnCheck"
                        Text="Check Palindrome"
                        CssClass="btn btn-primary"
                        OnClick="btnCheck_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-5">
                    <asp:Label runat="server" ID="lblResponse" />
                </div>
                <div class="col-5">
                    <asp:Label runat="server" ID="lblResponseBtn" />
                </div>
            </div>
        </section>
    </main>


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
            var lblResponseBtn = $('#<%= lblResponseBtn.ClientID %>');

            lblResponseBtn.text('');

            if (number === "") {
                lblResponse.text('');
                return;
            }

            var reversedNumber = number.split('').reverse().join('');

            if (number === reversedNumber) {
                lblResponse.text(number + ' IS a palindrome!').css('color', 'green');
            } else {
                lblResponse.text(number + ' is NOT a palindrome.').css('color', 'red');
            }
        }
    </script>
</asp:Content>

