<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Drawing" %>
<!DOCTYPE html>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["STUDENT_NAME"].ToString() + "學生你好";
        Label2.ForeColor = Color.Blue;
        Label2.Text = Session["STUDENT_NAME"] + "你好，請點選左項選單，選取功能";
        Label3.Text = "基於資訊安全</br>請注意當使用資訊系統過程中</br>若須離座請務必登出，以防止他人以更改資料</br>對本系統有任何建議或問題，請致電資圖處，由專人為您服務";
        Label2.BackColor = Color.White;
        Label3.BackColor = Color.White;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("../login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="S.css" />
        <style>
        #bimg2 {
            text-align: center;
        }

            #bimg2 span {
                position: relative;
                /*位置在這邊調整* top屬性 */
                top: 200px;
            }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="bimg1" class="auto-style1">
            <asp:Label ID="Label1" runat="server" Font-Size="20pt" />
             
            <div id="right">
            <asp:Button ID="Button1" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button1_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
            </div>
                <asp:TreeView ID="TreeView1" runat="server" Font-Size="20pt">
                <Nodes>
                
                    <asp:TreeNode NavigateUrl="~/S/S_index.aspx" Text="首頁" Value="首頁"></asp:TreeNode>
                    <asp:TreeNode Text="查詢缺曠" Value="查詢缺曠" NavigateUrl="~/S/S_ABSECE_LIST.aspx">
                    </asp:TreeNode>
                    <asp:TreeNode Text="請假審核" Value="請假審核" Expanded="False">
                        <asp:TreeNode Text="總表" Value="總表" NavigateUrl="~/S/S_TOTAL.aspx">
                            <asp:TreeNode NavigateUrl="~/S/S_check.aspx" Text="未審核" Value="未審核"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/S/S_Return.aspx" Text="退件" Value="退件"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="申請" Value="申請" NavigateUrl="~/S/S_Application.aspx"></asp:TreeNode>
                    </asp:TreeNode>
                </Nodes>
            </asp:TreeView>

            
        </div>
       
        <div id="bimg2">
            <asp:Label ID="Label2" runat="server" Font-Size="20pt" />

            <br />
            <asp:Label ID="Label3" runat="server" Font-Size="20pt" />

        </div>
    </form>
</body>
</html>
