<%@ Page Language="C#" Debug="true" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    private SqlCommand cmd;
    private SqlDataReader reader;
    private SqlConnection conn;
    private String sql;
        protected void Button4_Click(object sender, EventArgs e)
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
        Label1.Text = Session["TEACHER_NAME"].ToString() + "老師你好";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Button2.Visible = true;
        Button3.Visible = true;
        sql = "select * from COURSE where COURSE_NAME='" + DropDownList1.SelectedValue.ToString() + "'";
        DB_Context(sql);
        if (reader.Read())
        {
            Session["COURSE_ID"] = reader["COURSE_ID"];
            Session["SESSION_ID"] = reader["SESSION_ID"];
        }
        Label5.Text = Session["SESSION_ID"].ToString()+"節";
        reader.Close();
        conn.Close();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Label3.Text = "";
        int a = 0;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox[] cb = new CheckBox[9];
            cb[0] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            cb[1] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox2");
            cb[2] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox3");
            cb[3] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox4");
            cb[4] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox5");
            cb[5] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox6");
            cb[6] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox7");
            cb[7] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox8");
            cb[8] = (CheckBox)GridView1.Rows[i].FindControl("CheckBox9");

            String[] s = new String[100];
            s[i] =((Label)GridView1.Rows[i].FindControl("Label4")).Text;

            for (int j = 0; j < cb.Length; j++)
            {
                if (cb[j].Checked == true)
                {
                    a = j + 1;
                    Label3.Text += a;

                }
            }
            string q = "曠課";
            if (!Label3.Text.Equals("")) {
                sql = "INSERT INTO [ABSECE_LIST] " +"(STUDENT_ID,AL_DATETIME,TEACHER_ID,COURSE_ID,SESSION_ID,LEAVE_CATEGORY) VALUES" +
                        "('" +s[i]+ "','" + DateTime.Now.ToString("yyyy/MM/dd")+ "','" +
                Session["TEACHER_ID"] + "','" + Session["COURSE_ID"].ToString() + "','" +Label3.Text + "','"+q+"')";
                DB_Context(sql);
                Label3.Text = "";
            }
        }
        Label2.Text = "新增成功";
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox cb = (CheckBox)GridView1.Rows[i].FindControl("Checkbox1");
            cb.Checked = false;
        }
    }


    //protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
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
                <asp:Button ID="Button4" runat="server" Font-Size="X-Large" Height="32px" OnClick="Button4_Click" Text="登出" Width="72px" Font-Names="Tahoma" ForeColor="#000066" />
            </div>
            <asp:TreeView ID="TreeView1" runat="server" Font-Size="20pt">
                <Nodes>
                    <asp:TreeNode NavigateUrl="~/T/T_index.aspx" Text="首頁" Value="首頁"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/T/T_pointname.aspx" Text="點名" Value="點名" Expanded="False"></asp:TreeNode>
                    <asp:TreeNode Text="缺曠查詢" Value="缺曠查詢" Expanded="False">
                        <asp:TreeNode Text="任課查詢" Value="任課查詢" NavigateUrl="~/T/T_search.aspx"></asp:TreeNode>
                        <asp:TreeNode Text="導班查詢" Value="導班查詢" NavigateUrl="~/T/T_classteacher.aspx"></asp:TreeNode>
                    </asp:TreeNode>
                    <asp:TreeNode Expanded="False" Text="請假審核" Value="請假審核">
                        <asp:TreeNode NavigateUrl="~/T/T_check.aspx" Text="未審核" Value="未審核"></asp:TreeNode>
                        <asp:TreeNode NavigateUrl="~/T/T_checked.aspx" Text="已審核" Value="已審核"></asp:TreeNode>
                    </asp:TreeNode>
                </Nodes>
            </asp:TreeView>
            <br />
        </div>

        <div id="bimg2">
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="COURSE_NAME" DataValueField="COURSE_NAME" AppendDataBoundItems="True" Font-Size="Large" Height="30px" Width="140px">
                <asp:ListItem> 請選擇課程 </asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" Font-Size="Large" />
            <asp:Label ID="Label3" runat="server"></asp:Label>
            <asp:Label ID="Label5" runat="server"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT * FROM [COURSE] WHERE ([TEACHER_ID] = @TEACHER_ID)">
                <SelectParameters>
                    <asp:SessionParameter Name="TEACHER_ID" SessionField="TEACHER_ID" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="學號" SortExpression="學號">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("學號") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("學號") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Font-Size="X-Large" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="學生姓名" HeaderText="學生姓名" SortExpression="學生姓名">
                    <FooterStyle Font-Size="X-Large" />
                    <HeaderStyle Font-Size="X-Large" />
                    <ItemStyle Font-Size="Large" HorizontalAlign="Center" />

                    </asp:BoundField>
                    <asp:TemplateField HeaderText="1">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="2">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox2" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox2" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="3">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox3" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox3" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="4">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox4" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox4" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="5">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox5" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox5" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="6">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox6" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox6" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="7">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox7" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox7" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="8">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox8" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox8" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="9">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox9" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox9" runat="server" />
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
            <br />

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:lookConnectionString %>" SelectCommand="SELECT CHOOSECLASS.STUDENT_ID AS 學號, STUDENT.STUDENT_NAME AS 學生姓名, COURSE.COURSE_NAME FROM CHOOSECLASS INNER JOIN STUDENT ON CHOOSECLASS.STUDENT_ID = STUDENT.STUDENT_ID INNER JOIN COURSE ON CHOOSECLASS.COURSE_ID = COURSE.COURSE_ID AND CHOOSECLASS.COURSE_ID = COURSE.COURSE_ID WHERE (COURSE.COURSE_NAME = @COURSE_NAME) ORDER BY 學號">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="COURSE_NAME" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="Button2" runat="server" Font-Size="Medium" Text="確認" OnClick="Button2_Click" Visible="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button3" runat="server" Font-Size="Medium" Text="取消" OnClick="Button3_Click" Style="height: 26px" Visible="False" />
            <br />
            <asp:Label ID="Label2" runat="server"></asp:Label>
            <br />

        </div>
    </form>
</body>
</html>