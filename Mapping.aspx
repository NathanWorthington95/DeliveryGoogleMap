<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Mapping.aspx.cs" Inherits="Mapping" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <title>Draggable directions</title>
    <style type="text/css">
        #right-panel {
            font-family: 'Roboto','sans-serif';
            line-height: 30px;
            padding-left: 10px;
        }

            #right-panel select, #right-panel input {
                font-size: 15px;
            }

            #right-panel select {
                width: 100%;
            }

            #right-panel i {
                font-size: 12px;
            }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map {
            height: 100%;
            float: left;
            width: 63%;
            height: 100%;
        }

        #right-panel {
            float: right;
            width: 34%;
            height: 100%;
        }

        .panel {
            height: 100%;
            overflow: auto;
        }

        .auto-style1 {
            float: right;
            width: 564px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><%--Login content page--%> 
      <div class="row" style="margin-top: 50px">
           
        </div>
        <div class="row">
            <div class="session" style="  padding-right: 20px; ">
                <asp:Label ID="LblWelcome" runat="server" style="color: dodgerblue; font-size: 16px "/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8">
                <div id="map" style="width: 100%; height: 650px; position: fixed">
                </div>
            </div>

            <div class="col-md-4">
                <div id="right-panel" style="overflow-y: auto; max-height: 650px; width: 100%">
                    <p>Total Distance: <span id="total"></span></p>
                </div>
            </div>
            <script type="text/javascript">
                function initMap() {
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 12,
                        center: { lat: 53.483, lng: -2.24 }  // Centered Location
                    });
                    var directionsService = new google.maps.DirectionsService;
                    var directionsDisplay = new google.maps.DirectionsRenderer({
                        draggable: true,
                        map: map,
                        panel: document.getElementById('right-panel')
                    });

                    directionsDisplay.addListener('directions_changed', function () {
                        computeTotalDistance(directionsDisplay.getDirections());
                    });


                    displayRoute( {lat: 53.4781277, lng: -2.2246749}, {lat: 53.4781277, lng: -2.2246749}, directionsService, directionsDisplay); // Depot address

                }

                function displayRoute(origin, destination, service, display) {
                    service.route({
                        origin: origin,
                        destination: destination,
                        optimizeWaypoints: true,    
                        waypoints: <%=waypoints%>,
                        travelMode: 'DRIVING',
                        avoidTolls: true
                    }, function (response, status) {
                        if (status === 'OK') {
                            display.setDirections(response);
                        } else {
                            alert('Could not display directions due to: ' + status);
                        }
                    });
                }

                function computeTotalDistance(result) {
                    var total = 0;
                    var myroute = result.routes[0];
                    for (var i = 0; i < myroute.legs.length; i++) {
                        total += myroute.legs[i].distance.value;
                    }
                    total = total / 1000;
                    document.getElementById('total').innerHTML = total + ' km';
                }

                function selectMe(obj)
                {
                    obj.style.backgroundColor="beige";
                    obj.style.disabled=true;
                    obj.style.cursor='default';
                }
      
            </script>

        </div>
        <script  async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBX0FZR4vK1UKUKs2w2Ye59tkljJBy3SE&&callback=initMap"></script>

        <div class="row">
            <div class="col-md-offset-2 col-md-8 col-md-offset-2">
                <div class="table-responsive" id="Table1" >
                    <asp:GridView ID="GViewDriver" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" CssClass="table" OnRowDataBound="GridView1_RowDataBound" PageSize="4">
                        <Columns>
                            
                            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                            <asp:BoundField DataField="postcode" HeaderText="postcode" SortExpression="postcode" />
                            <asp:BoundField DataField="latitude" HeaderText="latitude" SortExpression="latitude" />
                            <asp:BoundField DataField="longitude" HeaderText="longitude" SortExpression="longitude" />

                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
<%--         <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="driverTableAdapters.postcodelatlngTableAdapter" UpdateMethod="Update">
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
        </asp:ObjectDataSource>--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PackagesDBConnectionString %>" SelectCommand="SELECT * FROM [postcodelatlng] WHERE ([driver] = @driver)">
            <SelectParameters>
                <asp:SessionParameter SessionField="DD" Name="driver" Type="String"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
   

</asp:Content>

