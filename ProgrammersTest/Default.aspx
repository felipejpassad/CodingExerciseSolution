<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="ProgrammersTest._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



    <main>
    <section class="row" aria-labelledby="pageTitle">
        <h1 id="pageTitle">Coding Exercise Solution</h1>
        <br/>
        <br/>
        <br/>
        <p>
            This project was developed as part of a technical evaluation using 
            <strong>VB.NET</strong>, <strong>WebForms</strong>, and <strong>jQuery</strong>.
        </p>
        <p>
            The solution contains implementations of two selected exercises:
        </p>
    </section>

    <section>
        <article>
            <h2>Exercise 1 – Number to Words Conversion</h2>
            <p>
                Converts a numeric amount into its string-based representation in dollars.
            </p>
            <p>
                <a class="btn btn-primary" runat="server" href="~/Palindrome">
                    Go to Exercise 1
                </a>
            </p>
        </article>

        <article>
            <h2>Exercise 6 – Palindrome Checker</h2>
            <p>
                Checks whether a positive number is a palindrome (reads the same forward and backward).
            </p>
            <p>
                <a class="btn btn-primary" runat="server" href="~/NumberToWords">
                    Go to Exercise 6
                </a>
            </p>
        </article>
    </section>
</main>

</asp:Content>
