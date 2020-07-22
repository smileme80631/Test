<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    private SqlCommand cmd;
    private SqlDataReader reader;
    private SqlConnection conn;
    private String sql;

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["TEACHER_NAME"].ToString() + "老師你好";
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("../login.aspx");
    }

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

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox[] cb = new CheckBox[1];
            cb[0] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            for (int j = 0; j < cb.Length; j++)
            {
                if (cb[j].Checked == true)
                {
                    Label LEAVE_ID = (Label)GridView1.Rows[i].FindControl("Label3");
                    Label2.Text = "審核成功";

                    string a = "已審核";
                    sql = "Update LEAVE set LEAVE_STATUS='" + a + "'WHERE LEAVE_ID='" + LEAVE_ID.Text + "'";
                    DB_Context(sql);
                    reader.Close();
                    conn.Close();
                    sql = "Update  ABSECE_LIST set ABSECE_LIST.LEAVE_CATEGORY =(Select LEAVE.LEAVE_CATEGORY )from LEAVE ,ABSECE_LIST where LEAVE.LEAVE_STATUS='已審核'and ABSECE_LIST.STUDENT_ID=LEAVE.STUDENT_ID and ABSECE_LIST.AL_DATETIME=LEAVE.LEAVE_TIME and ABSECE_LIST.SESSION_ID=LEAVE.SESSION_ID ";
                    DB_Context(sql);
                    reader.Close();
                    conn.Close();
                }
            }
        }
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox[] cb = new CheckBox[1];
            cb[0] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            CheckBox[] cb1 = new CheckBox[1];
            cb1[0] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox2");


            for (int j = 0; j < cb.Length; j++)
            {
                if (cb[j].Checked == true)
                {

                    Label LEAVE_ID = (Label)GridView1.Rows[i].FindControl("Label3");
                    Label2.Text = "審核成功";

                    string a = "退回";
                    sql = "Update LEAVE set LEAVE_STATUS='" + a + "'WHERE LEAVE_ID='" + LEAVE_ID.Text + "'";
                    DB_Context(sql);
                    reader.Close();
                    conn.Close();
                }
            }
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="T.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="bimg1" class="auto-style1">
            <asp:Label ID="Label1" runat="server" Font-Size="20pt" />
            <div id="right">
                <asp:Button ID="Button3" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button3_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
            </div>
            <asp:TreeView ID="TreeView1" runat="server" Font-Size="20pt">
                <Nodes>
                    <asp:TreeNode NavigateUrl="~/T/T_index.aspx" Text="首頁" Value="首頁"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/T/T_pointname.aspx" Text="點名" Value="點名" Expanded="False"></asp:TreeNode>
                    <asp:TreeNode Text="缺曠查詢" Value="缺曠查詢" Expanded="False">
                        <asp:TreeNode Text="任課查詢" Value="任課查詢" NavigateUrl="~/T/T_search.aspx"></asp:TreeNode>
                        <asp:TreeNode Text="導班查詢" Value="導班查詢" NavigateUrl="~/T/T_classteacher.aspx"></asp:TreeNode>
                    </asp:TreeNode>
                    <asp:TreeNode Expanded="True" Text="請假審核" Value="請假審核">
                        <asp:TreeNode NavigateUrl="~/T/T_check.aspx" Text="未審核" Value="未審核"></asp:TreeNode>
                        <asp:TreeNode NavigateUrl="~/T/T_checked.aspx" Text="已審核" Value="已審核"></asp:TreeNode>
                    </asp:TreeNode>
                </Nodes>
            </asp:TreeView>
        </div>
        <div id="bimg2">

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CssClass="auto-style1">
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
                    <asp:TemplateField HeaderText="審核">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("編號") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT LEAVE.LEAVE_ID AS 編號, LEAVE.STUDENT_ID AS 學號, STUDENT.STUDENT_NAME AS 姓名, CLASS.CLASS_NAME AS 班級, LEAVE.LEAVE_CATEGORY AS 假別, LEAVE.LEAVE_CAUSE AS 事由, LEAVE.LEAVE_TIME AS 日期, LEAVE.SESSION_ID AS 節次, LEAVE.LEAVE_STATUS AS 狀態 FROM LEAVE INNER JOIN STUDENT ON LEAVE.STUDENT_ID = STUDENT.STUDENT_ID INNER JOIN CLASS ON LEAVE.CLASS_ID = CLASS.CLASS_ID WHERE (CLASS.CLASS_ID = @CLASS_ID) AND (LEAVE.LEAVE_STATUS = '未審核')">
                <SelectParameters>
                    <asp:SessionParameter Name="CLASS_ID" SessionField="CLASS_ID" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:Button ID="Button1" runat="server" Text="審核" OnClick="Button1_Click" />

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="退回" />

            <br />
            <asp:Label ID="Label2" runat="server"></asp:Label>

            <br />

        </div>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>

    </form>
</body>
</html>
