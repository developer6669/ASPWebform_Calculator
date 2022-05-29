<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ASPWebform_Calculator._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h3>Calculator</h3>
        <div class="row">
            <div class="col-md-4 col-md-push-4">
                  <table class="table">
                     <tbody>
                         <tr>
                             <td colspan="3"><input class="form-control" type="text" id="Result"  /></td>
                         </tr>
                         <tr>
                             <td colspan="3"><button type="button" class="btn btn-default form-control clear" value="">CLR</button></td>
                             <td><button type="button" class="btn btn-danger form-control operator" value="/">/</button> </td>
                         </tr>
                         <tr>
                             <td><button type="button" class="btn btn-default" value="7">7</button></td>
                             <td><button type="button" class="btn btn-default" value="8">8</button></td>
                             <td><button type="button" class="btn btn-default" value="9">9</button></td>
                             <td><button type="button" class="btn btn-danger form-control operator" value="*">*</button></td>                                                                
                         </tr>
                         <tr>                                                               
                             <td><button type="button" class="btn btn-default" value="4">4</button></td>
                             <td><button type="button" class="btn btn-default" value="5">5</button></td>
                             <td><button type="button" class="btn btn-default" value="6">6</button></td>
                             <td><button type="button" class="btn btn-danger form-control operator" value="-">-</button></td>
                         </tr>
                         <tr>
                             <td><button type="button" class="btn btn-default" value="1">1</button></td>
                             <td><button type="button" class="btn btn-default" value="2">2</button></td>
                             <td><button type="button" class="btn btn-default" value="3">3</button></td>
                             <td><button type="button" class="btn btn-danger form-control operator" value="+">+</button> </td>                
                         </tr>
                         <tr>
                             <td><button type="button" class="btn btn-default" value="0">0</button></td>
                             <td colspan="3"><button type="button" class="btn btn-danger form-control result" value="">=</button></td>
                         </tr>
                     </tbody>
                 </table>
            </div>
        </div>
    </div>

    <!-- Join -->
    <script>
        $('.clear').click(function (e) {
            $("#Result").val("");
            operator = undefined;            
        });
        $('.result').click(function (e) {
            Calculate(operator, $("#Result").val());
        });
        $('.btn-default').click(function (e) {
            Join(e.target.value, $("#Result").val());
        });

        var operator;

        $('.operator').click(function (e) {

            var result = $("#Result").val();
            if (result == "") {
                return;
            }

            if (operator == undefined) {
                
                operator = e.target.value;
                Join(e.target.value, result);
                return;
            }

            if (result.slice(-1) == e.target.value) {
                return;
            }

            if (operator != e.target.value) {
                result = result.slice(0, -1);
                operator = e.target.value;
                Join(operator, result);
                return;
            }
            
            Calculate(operator, result);
        });

        function Join(Str, Result) {
            $.ajax({
                type: "POST", //POST
                url: "Default.aspx/Join",
                data: "{Str: '" + Str + "',Result:'"+ Result + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    //console.log(msg.d);
                    $("#Result").val(msg.d);
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            })
        }
    </script>

    <!-- Calculator -->
    <script>

        function Calculate(Operation, Result) {

            $.ajax({
                type: "POST", //POST
                url: "Default.aspx/Calculate",
                data: "{Operation: '" + Operation + "',Result:'" + Result + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    operator = undefined;
                    $("#Result").val(response.d);
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            })
        }
    </script>

</asp:Content>
