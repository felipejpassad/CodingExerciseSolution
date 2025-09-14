Public Class About
    Inherits Page


    'Public Property ResponseValue As String
    '    Get
    '        Return ViewState("ResponseValue")
    '    End Get
    '    Set(value As String)
    '        ViewState("ResponseValue") = value
    '    End Set
    'End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblResponse.Text = ""
            lblResponseBtn.Text = ""
        Else
            lblResponse.Text = hfValue.Value
        End If

    End Sub


    Protected Sub btnCheck_Click(sender As Object, e As EventArgs) Handles btnCheck.Click

        'ResponseValue = hfValue.Value

        Dim input As String = txtNumber.Text.Trim()

        If String.IsNullOrEmpty(input) Then
            lblResponseBtn.Text = "Please enter a number."
            lblResponseBtn.Style.Add("color", "red")
            hfValue.Value = ""
            lblResponse.Text = ""
            Return
        End If

        Dim number As Integer
        If Not Integer.TryParse(input, number) OrElse number < 0 Then
            lblResponseBtn.Text = "Invalid input. Please enter a positive number."
            lblResponseBtn.Style.Add("color", "red")
            Return
        End If

        ' Converte para string para checar palíndromo
        Dim numberStr As String = number.ToString()
        Dim reversedStr As String = StrReverse(numberStr)

        If numberStr = reversedStr Then
            lblResponseBtn.Text = "VB: " & number & " IS a palindrome!"
            lblResponseBtn.Style.Add("color", "green")
            lblResponse.Style.Add("color", "green")
        Else
            lblResponseBtn.Text = "VB: " & number & " is NOT a palindrome."
            lblResponseBtn.Style.Add("color", "red")
            lblResponse.Style.Add("color", "red")
        End If


    End Sub


End Class