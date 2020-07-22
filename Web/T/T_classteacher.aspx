<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        String sql = "";
        String sqldb = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=look;Persist Security Info=True;User ID=sa;Password=1234";
        SqlConnection conn = new SqlConnection(sqldb);
        conn.Open();
        sql = "select * from ABSECE_LIST";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader reader = cmd.ExecuteReader();
        Label1.Text=Session["TEACHER_NAME"].ToString()+"老師你好";
        reader.Close();
        conn.Close();

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
    <link rel="stylesheet" type="text/css" href="T.css"/>

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
                    <asp:TreeNode NavigateUrl="~/T/T_index.aspx" Text="首頁" Value="首頁"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/T/T_pointname.aspx" Text="點名" Value="點名" Expanded="False"></asp:TreeNode>
                    <asp:TreeNode Text="缺曠查詢" Value="缺曠查詢" Expanded="True">
                        <asp:TreeNode Text="任課查詢" Value="任課查詢" NavigateUrl="~/T/T_search.aspx"></asp:TreeNode>
                        <asp:TreeNode Text="導班查詢" Value="導班查詢" NavigateUrl="~/T/T_classteacher.aspx"></asp:TreeNode>
                    </asp:TreeNode>
                    <asp:TreeNode Expanded="False" Text="請假審核" Value="請假審核">
                        <asp:TreeNode NavigateUrl="~/T/T_check.aspx" Text="未審核" Value="未審核"></asp:TreeNode>
                        <asp:TreeNode NavigateUrl="~/T/T_checked.aspx" Text="已審核" Value="已審核"></asp:TreeNode>
                    </asp:TreeNode>
                </Nodes>
            </asp:TreeView>
        </div>
        <div id="bimg2">
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT ABSECE_LIST.STUDENT_ID AS 學號, STUDENT.STUDENT_NAME AS 姓名, ABSECE_LIST.AL_DATETIME AS 時間, COURSE.WEEK AS 星期, ABSECE_LIST.SESSION_ID AS 節次, COURSE.COURSE_NAME AS 課程, TEACHER_1.TEACHER_NAME AS 教師, ABSECE_LIST.LEAVE_CATEGORY AS 狀態 FROM ABSECE_LIST INNER JOIN STUDENT ON ABSECE_LIST.STUDENT_ID = STUDENT.STUDENT_ID INNER JOIN COURSE ON ABSECE_LIST.COURSE_ID = COURSE.COURSE_ID INNER JOIN TEACHER ON STUDENT.CLASS_ID = TEACHER.CLASS_ID INNER JOIN TEACHER AS TEACHER_1 ON ABSECE_LIST.TEACHER_ID = TEACHER_1.TEACHER_ID WHERE (TEACHER.CLASS_ID = @CLASS_ID)">
                <SelectParameters>
                    <asp:SessionParameter Name="CLASS_ID" SessionField="CLASS_ID" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="學號" HeaderText="學號" SortExpression="學號" >
                    </asp:BoundField>
                    <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" >
                    </asp:BoundField>
                    <asp:BoundField DataField="時間" HeaderText="時間" SortExpression="時間">
                    </asp:BoundField>
                    <asp:BoundField DataField="星期" HeaderText="星期" SortExpression="星期" />
                    <asp:BoundField DataField="節次" HeaderText="節次" SortExpression="節次" />
                    <asp:BoundField DataField="課程" HeaderText="課程" SortExpression="課程" />
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
            <br />
        </div>
    </form>
</body>
</html>
