<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><%--Login content page--%> 

<div class="box">

    <div class="content">   
        <h2>Login</h2>  

            <asp:TextBox runat="server" ID="uNameTextBox" class="field" PlaceHolder="Email"></asp:TextBox>  <%--Email entry--%> 
                <br />
            <asp:RequiredFieldValidator ID="uNameValidator" runat="server" ErrorMessage="Please enter username" ControlToValidate="uNameTextBox" ForeColor="Red"></asp:RequiredFieldValidator> <%--Validator to ensure email entry--%> 
                <br />
            <asp:textbox runat="server" ID="passwordTextBox" TextMode="Password" class="field" PlaceHolder="Password"></asp:textbox>    <%--password entry--%>
                <br />
            <asp:RequiredFieldValidator ID="passwordValidator" runat="server" ErrorMessage="Please enter password" ControlToValidate="passwordTextBox" ForeColor="Red"></asp:RequiredFieldValidator>    <%--Validator to ensure password entry--%>
                <br />
            <asp:button runat="server" text="Log in" ID="loginBtn" class="btn" OnClick="loginBtn_Click" />  <%--Login button--%>
                <br />
            <asp:Label ID="lblFail" runat="server" ForeColor="Red" Text="Incorrect login details" Visible="False"></asp:Label>  
                <br />
            <asp:HyperLink ID="newRegLink" runat="server" NavigateUrl="register.aspx">New users click here to register</asp:HyperLink>  <%--Link to Register Page--%> 

    </div>
</div>
</asp:Content>