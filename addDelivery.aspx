<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="addDelivery.aspx.cs" Inherits="addDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
            <h2>Warehouse parcels</h2>
                
            
                <label>Package ID:<asp:Button ID="bcodeButton" runat="server" OnClick="bcodeButton_Click" Text="Gen Barcode" /></label>
                    <asp:TextBox ID="TxtPackID" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="TxtPackIDValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtPackID" ErrorMessage="Please enter generate a barcode"></asp:RequiredFieldValidator>
                            <br />
                <label>Name:</label>
                    <asp:TextBox ID="TxtCustomerName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="TxtCustomerNameValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtCustomerName" ErrorMessage="Please enter the customer name"></asp:RequiredFieldValidator>
                            <br />
                <label>Driver:</label>
                    <asp:TextBox ID="TxtDriver" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="TxtDriverValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtDriver" ErrorMessage="Please enter the driver username"></asp:RequiredFieldValidator>           
                            <br />
                <label>Postcode:</label>
                    <asp:TextBox ID="TxtPostcode" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="TxtPostcodeValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtPostcode" ErrorMessage="Please enter a postcode"></asp:RequiredFieldValidator>           
                            <asp:RegularExpressionValidator ID="postcodeValidator" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Enter a valid UK postcode" ControlToValidate="TxtPostcode" ValidationExpression="^([A-PR-UWYZ0-9][A-HK-Y0-9][AEHMNPRTVXY0-9]?[ABEHMNPRVWXY0-9]? {1,2}[0-9][ABD-HJLN-UW-Z]{2}|GIR 0AA)$"></asp:RegularExpressionValidator>
                            <br />
                <label>Latitude:</label>
                    <asp:TextBox ID="latTextBox" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="latTextBoxValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="latTextBox" ErrorMessage="Please enter a latitude value"></asp:RequiredFieldValidator>           
                            <br />
                <label>Longitude:</label>
                    <asp:TextBox ID="lngTextBox" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="lngTextBoxValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="lngTextBox" ErrorMessage="Please enter a longitude value"></asp:RequiredFieldValidator>            
                            <br />
                <label>Contact number:</label>
                    <asp:TextBox ID="TxtContactNum" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="TxtContactNumValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtContactNum" ErrorMessage="Please enter a contact number"></asp:RequiredFieldValidator>           
                            <asp:RegularExpressionValidator ID="numberValidator" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="TxtContactNum" ValidationExpression="[0-9]{11}" ErrorMessage="Please enter an 11 digit number"></asp:RegularExpressionValidator>
                                <br />
                <label>Delivery point:</label>
                    <asp:TextBox ID="TxtUnavailbleOption" runat="server" CssClass="form-control" />

            <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="BtnSubmit_Click" />
            <asp:Label ID="LBlValid" runat="server" Visible="false"></asp:Label>

            <hr />

            <h3>Csv File uploader</h3>

            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="BtnUploadCsv" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="BtnUploadCsv_Click" />
            <asp:Label ID="LblCsv" runat="server"></asp:Label>

        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-2 col-md-8 col-md-offset-2">
            <div class="table-responsive" id="Table1">
                <asp:GridView ID="GViewDriver" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource1" CssClass="table">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                        <asp:BoundField DataField="postcode" HeaderText="postcode" SortExpression="postcode" />
                        <asp:BoundField DataField="latitude" HeaderText="latitude" SortExpression="latitude" />
                        <asp:BoundField DataField="longitude" HeaderText="longitude" SortExpression="longitude" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="driverTableAdapters.postcodelatlngTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="postcode" Type="String" />
            <asp:Parameter Name="latitude" Type="Decimal" />
            <asp:Parameter Name="longitude" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="postcode" Type="String" />
            <asp:Parameter Name="latitude" Type="Decimal" />
            <asp:Parameter Name="longitude" Type="Decimal" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PackagesDBConnectionString %>" SelectCommand="SELECT * FROM [postcodelatlng]"></asp:SqlDataSource>

</asp:Content>

