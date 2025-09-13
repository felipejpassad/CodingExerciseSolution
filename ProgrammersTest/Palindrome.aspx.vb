Public Class About
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblResponse.Text = ""
            lblResponseBtn.Text = ""
        End If
    End Sub


    Protected Sub btnCheck_Click(sender As Object, e As EventArgs) Handles btnCheck.Click
        lblResponseBtn.CssClass = ""
        lblResponseBtn.Text = ""

        Dim input As String = txtNumber.Text.Trim()

        If String.IsNullOrEmpty(input) Then
            lblResponseBtn.Text = "Please enter a number."
            lblResponseBtn.CssClass = "text-warning"
            Return
        End If

        Dim number As Integer
        If Not Integer.TryParse(input, number) OrElse number < 0 Then
            lblResponseBtn.Text = "Invalid input. Please enter a positive number."
            lblResponseBtn.CssClass = "text-danger"
            Return
        End If

        ' Converte para string para checar palíndromo
        Dim numberStr As String = number.ToString()
        Dim reversedStr As String = StrReverse(numberStr)

        If numberStr = reversedStr Then
            lblResponseBtn.Text = number & " is a palindrome."
            lblResponseBtn.CssClass = "text-success"
        Else
            lblResponseBtn.Text = number & " is NOT a palindrome."
            lblResponseBtn.CssClass = "text-danger"
        End If
    End Sub


End Class