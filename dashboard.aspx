<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="GGlimpse.AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--Responses--%>
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

        <EditRowStyle BackColor="#999999"></EditRowStyle>

        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

        <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>

        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Sender" ReadOnly="true" InsertVisible="false" />
            <asp:BoundField DataField="ContactNo" HeaderText="Sender Contact" ReadOnly="true" InsertVisible="false" />
            <asp:BoundField DataField="Email" HeaderText="Sender MailID" ReadOnly="true" InsertVisible="false" />
            <asp:BoundField DataField="Response" HeaderText="Response" ReadOnly="true" InsertVisible="false" />
        </Columns>
    </asp:GridView>
            </div>
        </section>
    </div>
</asp:Content>
