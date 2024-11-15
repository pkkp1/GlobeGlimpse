<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GGlimpse.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />  
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css" />  
    <link rel="stylesheet" href="../plugins/icheck-bootstrap/icheck-bootstrap.min.css" />  
    <link rel="stylesheet" href="../dist/css/adminlte.min.css" />
</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
        <div>
            <div class="login-box">
                <div class="card card-outline card-primary">
                    <div class="card-header text-center">
                        <a href="default.aspx" class="h1">Globe Glimpse</a>
                    </div>
                    <div class="card-body">
                        <p class="login-box-msg">Sign in to start your session</p>
                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Email" ID="UserMailID" placeholder="example@gmail.com" />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope" runat="server" id="spn"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" ID="UserPwd" placeholder="Password" />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <asp:Label ID="Label1" runat="server" Text="" ForeColor="red" />
                        <div class="row">
                            <div class="col-4">
                                <asp:Button CssClass="btn btn-primary btn-block" Text="Login" runat="server" ID="UserLogin" OnClick="UserLogin_Click" />
                            </div>
                        </div>
                        <p class="mb-1">
                            <a href="forgot_pass.aspx">I forgot my password</a>
                        </p>
                        <span class="center-text">
                            Don't have an account?
                            <asp:LinkButton Text="Sign Up instead" runat="server" PostBackUrl="~/SignUp.aspx" />
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </form>
  <script src="../plugins/jquery/jquery.min.js"></script>  
  <script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>  
  <script src="../dist/js/adminlte.min.js"></script>
</body>
</html>
