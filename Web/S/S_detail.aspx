<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Drawing" %>

<!DOCTYPE html>

<script runat="server">
    private SqlCommand cmd;
    private SqlDataReader reader;
    private SqlConnection conn;
    private String sql;
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        DateTime dt = Convert.ToDateTime(Calendar1.SelectedDate.ToLongDateString());
        TextBox2.Text = dt.ToShortDateString();
    }
        protected void Button2_Click(object sender, EventArgs e)
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
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Session["STUDENT_NAME"].ToString() + "學生你好";

        String sql = "", str = "";
        String sqldb = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=look;Persist Security Info=True;User ID=sa;Password=1234";
        SqlConnection conn = new SqlConnection(sqldb);
        conn.Open();
        sql = "select * from LEAVE where LEAVE_ID='" + Session["LEAVE_ID"].ToString() + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            DropDownList1.Text = reader[3].ToString();
            TextBox1.Text = reader[4].ToString();
            TextBox2.Text = reader[5].ToString();
        }

        else
        {
            DropDownList1.Text = "";
            TextBox1.Text = "";
            TextBox2.Text = "";
            CheckBoxList1.Text = "";
            Label2.Text = "查無紀錄!";
        }
        reader.Close();
        conn.Close();
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        string a = "未審核";
        string habits = "";
        for (int i = 0; i < CheckBoxList1.Items.Count; i++)
        {
            if (CheckBoxList1.Items[i].Selected)
            {
                habits += CheckBoxList1.Items[i].Text;
            }

        }

        sql = "Insert into LEAVE values('" + Session["STUDENT_ID"] + "','" + Session["CLASS_ID"] + "','" + DropDownList1.SelectedValue.ToString() + "','" + TextBox1.Text + "','" + TextBox2.Text + "','" + habits + "','" + a + "')";
        DB_Context(sql);
        Label2.Text = "新增成功!";
    }



    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string v1 = reader[6].ToString().Substring(0, 1);
        string v2 = reader[6].ToString().Substring(1, 2);
        string v3 = reader[6].ToString().Substring(2, 3);
        //Label2.Text = v;
        string[] w = new string[4];
        w[0] = v1;
        w[1] = v2;
        w[2] = v3;
        for (int i = 0; i < CheckBoxList1.Items.Count; i++)
        {
            for (int q = 0; q < 3; q++)
            {
                if (w[q] == "i")
                {
                    CheckBoxList1.Items[i].Selected = true;
                }
            }
        }
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
            <asp:Button ID="Button2" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button2_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
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
            <table class="auto-style2">
                <tr>
                    <td class="auto-style9">假別</td>
                    <td class="auto-style10" rowspan="1">
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>病假</asp:ListItem>
                            <asp:ListItem>事假</asp:ListItem>
                            <asp:ListItem>喪假</asp:ListItem>
                            <asp:ListItem>婚假</asp:ListItem>
                            <asp:ListItem>產假</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">事由</td>
                    <td class="auto-style10" rowspan="1">
                        <asp:TextBox ID="TextBox1" runat="server" Height="30px" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">日期</td>
                    <td class="auto-style12" rowspan="1">
                        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9" aria-disabled="True">節數</td>
                    <td aria-disabled="True" class="auto-style10" rowspan="1">
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style8" colspan="2">
                        <asp:Button ID="Button1" runat="server" Text="送出" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="Label2" runat="server"></asp:Label>
        </div>
    </form></body>
</html>
