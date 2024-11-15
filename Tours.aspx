<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tours.aspx.cs" Inherits="GGlimpse.Tours" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
    <link rel="stylesheet" href="css/templatemo-style.css" />
    <style>
        .tm-top-bar {
            border-bottom: 1px solid #323B60;
        }

        .tours-wrap {
            display: grid;
            grid-template-columns: repeat(2, 650px);
            gap: 20px;
            margin-left: 25px;
            margin-bottom: 60px;
        }

        .tm-recommended-title {
            font-size: 1rem;
        }

        .tm-recommended-place {
            border: 2px solid #CEAF72;
            width: 640px;
            margin-bottom: 0px;
        }

        .tm-recommended-description-box {
            padding: 5px 20px;
        }

        .tm-recommended-price-box {
            width: 450px;
            padding-left: 60px;
        }

        .tm-text-highlight, .tm-text-gray {
            margin-bottom: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="tm-page-wrap" style="z-index: 4!important; position: sticky!important;">
            <div class="tm-main-content" id="top">
                <div class="tm-top-bar-bg"></div>
                <div class="tm-top-bar" id="tm-top-bar">
                    <div class="container">
                        <div class="row">
                            <nav class="navbar navbar-expand-lg narbar-light">
                                <a class="navbar-brand mr-auto" style="font-family: 'TT Norms',sans-serif; font-size: large" href="Default.aspx">
                                    <img src="img/logo/navlogo.png" alt="Site logo" />
                                    <strong style="color: #CEAF72;">Globe</strong>&nbsp;&nbsp;<strong style="color: #323B60;">Glimpse</strong>
                                </a>
                                <button type="button" id="nav-toggle" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#mainNav" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div id="mainNav" class="collapse navbar-collapse tm-bg-white">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item">
                                            <a id="nl1" class="nav-link active" href="./Default.aspx">Home <span class="sr-only">(current)</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl2" class="nav-link" href="#tm-section-2">Top Destinations</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl3" class="nav-link" href="#tm-section-3">Recommended Places</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl4" class="nav-link" href="#tm-section-4">Contact Us</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                        <!-- row -->
                    </div>
                    <!-- container -->
                </div>
                <!-- .tm-top-bar -->

            </div>
            <section class="p-5 tm-container-outer">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
                            <h2 class="text-uppercase mb-4">The Beautiful country of <strong>
                                <asp:Label Text="text" ID="CountryName" runat="server" /></strong></h2>
                            <p class="mb-4">
                                <asp:Label Text="text" ID="CountryDesc" runat="server" />
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            <div class="tm-recommended-place-wrap tours-wrap">
                <asp:Repeater ID="ToursLst" runat="server" ItemType="GGlimpse.DataModels.Tour">
                    <ItemTemplate>
                        <div class="tm-recommended-place">
                            <img src='<%# Item.img %>' alt="Image" class="img-fluid tm-recommended-img" />
                            <div class="tm-recommended-description-box">
                                <h3 class="tm-recommended-title">
                                    <asp:Label Text='<%# Item.name%>' runat="server" /></h3>
                                <p class="tm-text-highlight">Cities</p>
                                <p class="tm-text-gray"><%# String.Join(", ",Item.cities) %></p>
                                <p class="tm-text-highlight">Hotels:</p>
                                <p class="tm-text-gray"><%# String.Join(", ",Item.hotel) %></p>
                                <p class="tm-text-highlight">Features:</p>
                                <p class="tm-text-gray"><%# String.Join(", ",Item.features) %></p>
                                <p class="tm-text-highlight">For <%# Item.days %></p>
                            </div>
                            <a href='<%# Item.link %>' target="_blank" class="tm-recommended-price-box">
                                <p class="tm-recommended-price">₹ <%#Item.price[0]%></p>
                                <p class="tm-recommended-price-link">Details</p>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <footer class="tm-container-outer" style="background-color: #AB7836;">
                <p class="mb-0">
                    Copyright © <span class="tm-current-year">2018</span> GlobeGlimpse
                        
                    . Designed by <a rel="nofollow" href="http://www.google.com/+templatemo" target="_parent">PSK</a>
                </p>
            </footer>

        </div>
    </form>
</body>
</html>
