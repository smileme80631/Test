<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["STUDENT_NAME"].ToString() + "學生你好";

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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="S.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="bimg1">
            <asp:Label ID="Label1" runat="server" Font-Size="20pt" />
            <div id="right">
            <asp:Button ID="Button1" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button1_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
            </div>


            <asp:TreeView ID="TreeView1" runat="server" Font-Size="20pt">
                <Nodes>
                    <asp:TreeNode NavigateUrl="~/S/S_index.aspx" Text="首頁" Value="新節點"></asp:TreeNode>
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

            <br />

        </div>
        <div id="bimg2">

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="時間" HeaderText="時間" SortExpression="時間" >
                    </asp:BoundField>
                    <asp:BoundField DataField="節次" HeaderText="節次" SortExpression="節次" >
                    </asp:BoundField>
                    <asp:BoundField DataField="課程" HeaderText="課程" SortExpression="課程">
                    </asp:BoundField>
                    <asp:BoundField DataField="教師" HeaderText="教師" SortExpression="教師" />
                    <asp:BoundField DataField="狀態" HeaderText="狀態" SortExpression="狀態" />
                </Columns>
                <EditRowStyle BackColor="#FFFFFF" />
                <FooterStyle BackColor="#FFFFFF" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FFF0C3" Font-Bold="True" ForeColor="000000" />
                <PagerStyle BackColor="#FFFFFF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFFFF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT ABSECE_LIST.AL_DATETIME AS 時間, ABSECE_LIST.SESSION_ID AS 節次, COURSE.COURSE_NAME AS 課程, TEACHER.TEACHER_NAME AS 教師, ABSECE_LIST.LEAVE_CATEGORY AS 狀態 FROM ABSECE_LIST INNER JOIN STUDENT ON ABSECE_LIST.STUDENT_ID = STUDENT.STUDENT_ID INNER JOIN TEACHER ON ABSECE_LIST.TEACHER_ID = TEACHER.TEACHER_ID INNER JOIN COURSE ON ABSECE_LIST.COURSE_ID = COURSE.COURSE_ID WHERE (ABSECE_LIST.STUDENT_ID = @STUDENT_ID)">
                <SelectParameters>
                    <asp:SessionParameter Name="STUDENT_ID" SessionField="STUDENT_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form></body>
</html>
