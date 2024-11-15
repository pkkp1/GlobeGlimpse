<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="GGlimpse.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css" />
    <link rel="stylesheet" href="../plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
    <link rel="stylesheet" href="../dist/css/adminlte.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="hold-transition register-page">
                <div class="register-box">
                    <div class="card card-outline card-primary">
                        <div class="card-header text-center" style="padding-bottom: 0px;">
                            <a href="../../index2.html" class="h1">Tolani Commerce College</a>
                        </div>
                        <div class="card-body" style="margin-top: 0px">
                            <p class="login-box-msg">Register as Student</p>
                            <div>
                                <div class="input-group mb-3">
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="SingleLine" ID="UserName" placeholder="Username" />
                                    <asp:RequiredFieldValidator Display="none" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Valid Name" ControlToValidate="UserName" ForeColor="red"></asp:RequiredFieldValidator>
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <span class="fas fa-user"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <asp:TextBox runat="server" TextMode="Email" CssClass="form-control" ID="UserMailID" placeholder="example@gmail.com" />
                                    <asp:RequiredFieldValidator Display="none" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Valid Email" ControlToValidate="UserMailID" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Valid Email." Display="None" ControlToValidate="UserMailID" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <span class="fas fa-envelope"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <asp:TextBox runat="server" TextMode="Password" ID="UserPwd" placeholder="Password" CssClass="form-control" />
                                    <asp:RequiredFieldValidator Display="none" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Valid Password" ControlToValidate="UserPwd" ForeColor="red"></asp:RequiredFieldValidator>
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <span class="fas fa-lock"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <asp:TextBox ID="UserCfPwd" TextMode="Password" CssClass="form-control" runat="server" placeholder="Retype password"></asp:TextBox>
                                    <asp:RequiredFieldValidator Display="none" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Valid Confirmed Password." ControlToValidate="UserCfPwd" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator Display="None" ID="CompareValidator1" runat="server" ErrorMessage="Password should be same." ControlToCompare="UserPwd" ControlToValidate="UserCfPwd" Type="String"></asp:CompareValidator>
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <span class="fas fa-lock"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <asp:Button Text="Register" runat="server" CssClass="btn btn-primary btn-block" ID="UserRegister" OnClick="UserRegister_Click" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="red" />
                                    </div>
                                </div>
                            </div>
                            <span class="text-center">Already have an account ?
                                <asp:LinkButton Text="Login instead" runat="server" PostBackUrl="~/Login.aspx" /></span>
                        </div>
                    </div>
                </div>
                <script src="../plugins/jquery/jquery.min.js"></script>
                <script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="../dist/js/adminlte.min.js"></script>
            </div>
        </div>
    </form>
</body>
</html>
