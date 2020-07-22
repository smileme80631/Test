<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    private SqlCommand cmd;
    private SqlDataReader reader;
    private SqlConnection conn;
    private String sql;

    private void DB_Context(String sql)
    {
        String sqldb = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=look;Persist Security Info=True;User ID=sa;Password=1234";
        conn = new SqlConnection(sqldb);
        conn.Open();
        cmd = new SqlCommand(sql, conn);
        reader = cmd.ExecuteReader();
    }
        protected void Button1_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("../login.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["STUDENT_NAME"].ToString() + "學生你好";
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
                    <asp:TreeNode NavigateUrl="~/S/S_index.aspx" Text="首頁" Value="首頁"></asp:TreeNode>
                    <asp:TreeNode Text="查詢缺曠" Value="查詢缺曠" NavigateUrl="~/S/S_ABSECE_LIST.aspx">
                    </asp:TreeNode>
                    <asp:TreeNode Text="請假審核" Value="請假審核" Expanded="True">
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
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333"  >
                 <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="學號" HeaderText="學號" SortExpression="學號" />
                    <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                    <asp:BoundField DataField="班級" HeaderText="班級" SortExpression="班級" />
                    <asp:BoundField DataField="假別" HeaderText="假別" SortExpression="假別" />
                    <asp:BoundField DataField="事由" HeaderText="事由" SortExpression="事由" />
                    <asp:BoundField DataField="日期" HeaderText="日期" SortExpression="日期" />
                    <asp:BoundField DataField="節次" HeaderText="節次" SortExpression="節次" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT LEAVE.LEAVE_ID AS 編號, LEAVE.STUDENT_ID AS 學號, STUDENT.STUDENT_NAME AS 姓名, CLASS.CLASS_NAME AS 班級, LEAVE.LEAVE_CATEGORY AS 假別, LEAVE.LEAVE_CAUSE AS 事由, LEAVE.LEAVE_TIME AS 日期, LEAVE.SESSION_ID AS 節次, LEAVE.LEAVE_STATUS AS 狀態 FROM LEAVE INNER JOIN STUDENT ON LEAVE.STUDENT_ID = STUDENT.STUDENT_ID INNER JOIN CLASS ON LEAVE.CLASS_ID = CLASS.CLASS_ID WHERE (LEAVE.STUDENT_ID = @STUDENT_ID) AND (LEAVE.LEAVE_STATUS = '未審核')">
                <SelectParameters>
                    <asp:SessionParameter Name="STUDENT_ID" SessionField="STUDENT_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label2" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
