<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Drawing" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["A_NAME"].ToString() + "管理員你好";
        Label2.ForeColor = Color.Blue;
        Label2.Text = Session["A_NAME"] + "你好，請點選左項選單，選取功能";
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
    <link rel="stylesheet" type="text/css" href="A.css" />
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
        <div id="bimg1">
            <asp:Label ID="Label1" runat="server" Font-Size="20pt" />
            <div id="right">
            <asp:Button ID="Button1" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button1_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
            </div>


            <asp:TreeView ID="TreeView1" runat="server" Font-Size="20pt" style="margin-right: 1px">
                <Nodes>
                    <asp:TreeNode NavigateUrl="~/administrator/A_index.aspx" Text="首頁" Value="點名" Expanded="True">
                        <asp:TreeNode Text="學生" Value="學生" Expanded="False">
                            <asp:TreeNode NavigateUrl="~/administrator/S_I.aspx" Text="新增學生" Value="新增學生"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/S_U.aspx" Text="更新學生" Value="更新學生"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/S_D.aspx" Text="刪除學生" Value="刪除學生"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="教師" Value="教師" Expanded="False">
                            <asp:TreeNode Text="新增教師" Value="新增教師" NavigateUrl="~/administrator/T_I.aspx"></asp:TreeNode>
                            <asp:TreeNode Text="更新教師" Value="更新學生" NavigateUrl="~/administrator/T_U.aspx"></asp:TreeNode>
                            <asp:TreeNode Text="刪除教師" Value="刪除教師" NavigateUrl="~/administrator/T_D.aspx"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="班級" Value="班級" Expanded="False">
                            <asp:TreeNode NavigateUrl="~/administrator/CL_I.aspx" Text="新增班級" Value="新節點"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CL_U.aspx" Text="更新班級" Value="更新班級"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CL_D.aspx" Text="刪除班級" Value="刪除班級"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="課程" Value="課程" Expanded="False">
                            <asp:TreeNode Text="新增課程" Value="新增課程" NavigateUrl="~/administrator/C_I.aspx"></asp:TreeNode>
                            <asp:TreeNode Text="更新課程" Value="更新課程" NavigateUrl="~/administrator/C_U.aspx"></asp:TreeNode>
                            <asp:TreeNode Text="刪除課程" Value="刪除課程" NavigateUrl="~/administrator/C_D.aspx"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="科系" Value="科系" Expanded="False">
                            <asp:TreeNode NavigateUrl="~/administrator/D_I .aspx" Text="新增科系" Value="新增科系"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/D_U.aspx" Text="更新科系" Value="更新科系"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/D_D.aspx" Text="刪除科系" Value="刪除科系"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Text="修課" Value="修課" Expanded="False">
                            <asp:TreeNode NavigateUrl="~/administrator/CH_I.aspx" Text="新增修課" Value="新增修課"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CH_U.aspx" Text="更新修課" Value="更新修課"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CH_D.aspx" Text="刪除修課" Value="刪除修課"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Expanded="False" Text="教室" Value="教室">
                            <asp:TreeNode NavigateUrl="~/administrator/CR_I.aspx" Text="新增教室" Value="新增教室"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CR_U.aspx" Text="更新教室" Value="更新教室"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/CR_D.aspx" Text="刪除教室" Value="刪除教室"></asp:TreeNode>
                        </asp:TreeNode>
                        <asp:TreeNode Expanded="False" Text="節次" Value="節次">
                            <asp:TreeNode NavigateUrl="~/administrator/SE_I.aspx" Text="新增節次" Value="新增節次"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/SE_U.aspx" Text="更新節次" Value="更新節次"></asp:TreeNode>
                            <asp:TreeNode NavigateUrl="~/administrator/SE_D.aspx" Text="刪除節次" Value="刪除節次"></asp:TreeNode>
                        </asp:TreeNode>
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
