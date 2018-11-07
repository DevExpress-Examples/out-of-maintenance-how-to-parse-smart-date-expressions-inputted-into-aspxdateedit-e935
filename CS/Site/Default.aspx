<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxEditors"
    TagPrefix="dxe" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>How to parse smart date expressions inputted into ASPxDateEdit</title>
<!--region #Markup-->
<script type="text/javascript" language="javascript">
           
        function SmartParseDate(value){
            var dayDeltas = {
                "TODAY": 0, 
                "TOMMOROW": 1,
                "YESTERDAY": -1,
                "NOW": 0
            };
            var ret = null;
            
            if(_aspxIsExists(value)){
                var text = value.replace(/ /g,"");
                text = text.toUpperCase();
                
                for(var day in dayDeltas){
                    if(text.substr(0,day.length) == day){
                        text = text.substr(day.length);
                        
                        var dayCount = parseInt(text);
                        if(isNaN(dayCount))
                            dayCount = 0;
                        
                        var dateResult = new Date();
                        if(day != "NOW")
                            dateResult.setHours(0,0,0,0);
                        dateResult.setDate(dateResult.getDate() + dayCount + dayDeltas[day])
                        if(!isNaN(dateResult))
                            ret = dateResult;
                    }
                }
            }
            return ret;
        }

        function OnParseDate(editor, args){
            var date = SmartParseDate(args.value);
            if (date != null) {
                args.date = date;
                args.handled = true;
            }
        }
        
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dxe:ASPxLabel ID="ASPxLabel1" runat="server" AssociatedControlID="ASPxDateEdit1"
            Text="Type a specific predefined word or expression (such as 'today + 1') within the date editor and press ENTER.">
        </dxe:ASPxLabel><dxe:aspxdateedit id="ASPxDateEdit1" runat="server" EditFormat="DateTime">
            <ClientSideEvents ParseDate="function (s, e){
                OnParseDate(s, e);
            } ">
            </ClientSideEvents>
    </dxe:aspxdateedit>
    <!--endregion #Markup-->
    <br />
        The following smart input constants (which can be used in case-insensitive manner)
        are supported within this example:<br />
        <ul>
            <li>"TODAY"</li>
            <li>"YESTERDAY"</li>
            <li>"TOMMOROW"</li>
            <li>"NOW"</li>
        </ul>
        Simple expressions like "today - 2" are also resolved.<br />
    <div style="display: none;"><input /></div>
    </div>
    </form>
</body>
</html>
