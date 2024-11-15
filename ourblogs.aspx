<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ourblogs.aspx.cs" Inherits="GGlimpse.ourblogs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Our Blogs</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
    <!-- Google web font "Open Sans" -->
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- Bootstrap style -->
    <link rel="stylesheet" type="text/css" href="css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
    <link rel="stylesheet" href="css/templatemo-style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
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
                                            <a id="nl1" class="nav-link active" href="#top">Home <span class="sr-only">(current)</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl2" class="nav-link" href="#tm-section-2">Top Destinations</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl3" class="nav-link" href="#tm-section-3">Recommended Places</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" style="z-index: 1000;" id="blg" href="ourblogs.aspx">Our Blogs</a>
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
                <section class="p-5 tm-container-outer" style="background: white;">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
                                <h2 class="text-uppercase mb-4">Our <strong>Blogs</strong></h2>
                                <p class="mb-4">Here are some of the most amazing blogs authored by our members of various places they went on and clicked amazing pictures. The description given makes anyone want to go on the given trip as soon as possible! We hope you find our blogs enjoyable as well as informational.</p>
                            </div>
                        </div>
                    </div>
                </section>
                <div class="tm-page-wrap mx-auto" style="display: none; max-height: 1px!important;">
                    <section class="tm-banner">
                        <div class="tm-container-outer tm-banner-bg">
                            <div class="container">
                                <div class="row tm-banner-row tm-banner-row-header">
                                    <div id="chartdiv"></div>

                                    <div class="tm-banner-header">
                                        <h2 style="display: none;" id="ctry-id"></h2>
                                    </div>
                                </div>
                                <div class="form-row tm-search-form-row">
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
                                        <label for="inputCheckIn">Check In Date</label>
                                        <input name="check-in" type="text" class="form-control" id="inputCheckIn" placeholder="Check In" />
                                    </div>
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
                                        <label for="inputCheckOut">Check Out Date</label>
                                        <input name="check-out" type="text" class="form-control" id="inputCheckOut" placeholder="Check Out" />
                                    </div>
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-1">
                                        <label for="btnSubmit">&nbsp;</label>
                                        <button type="submit" class="btn btn-primary tm-btn tm-btn-search text-uppercase" id="btnSubmit">Check Availability</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="tm-page-wrap" style="z-index: 4!important; position: sticky!important;">
                    <div class="tm-container-outer" id="tm-section-2">
                        <asp:Repeater runat="server" ID="BlogsRepeater" ItemType="GGlimpse.DataModels.BlogModel" OnItemDataBound="BlogsRepeater_ItemDataBound">
                            <ItemTemplate>
                                <section class="clearfix tm-slideshow-section">
                                    <div class="tm-slideshow">
                                        <asp:Repeater ID="repeaterImages" runat="server">
                                            <ItemTemplate>
                                                <img src='<%# ResolveUrl(Container.DataItem.ToString()) %>' alt="Image" />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <div class="tm-slideshow-description tm-bg-primary">
                                        <h2 class=""><%# Item.Title %></h2>
                                        <p><%# Item.Post %></p>
                                    </div>
                                </section>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <section class="clearfix tm-slideshow-section tm-slideshow-section-reverse">

                                    <div class="tm-right tm-slideshow tm-slideshow-highlight">
                                        <asp:Repeater ID="repeaterImages" runat="server">
                                            <ItemTemplate>
                                                <img src='<%# ResolveUrl(Container.DataItem.ToString()) %>' alt="Image" />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="tm-slideshow-description tm-slideshow-description-left tm-bg-highlight">
                                        <h2 class=""><%# Item.Title %></h2>
                                        <p><%# Item.Post %></p>
                                    </div>

                                </section>
                            </AlternatingItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>
            </div>
            <footer class="tm-container-outer" style="background-color: #AB7836;">
                <p class="mb-0">
                    Copyright © <span class="tm-current-year">2018</span> GlobeGlimpse
           
       . Designed by <a rel="nofollow" href="http://www.google.com/+templatemo" target="_parent">PSK</a>
                </p>
            </footer>
            <footer style="display: none;">
                <script src="js/jquery-1.11.3.min.js"></script>
                <script src="js/popper.min.js"></script>
                <script src="js/bootstrap.min.js"></script>
                <script src="js/datepicker.min.js"></script>
                <script src="js/jquery.singlePageNav.min.js"></script>
                <script src="slick/slick.min.js"></script>
                <script src="js/jquery.scrollTo.min.js"></script>
                <script src="globe/script.js"></script>
                <script> 

               /* DOM is ready
               ------------------------------------------------*/
               $(function () {

                   // Change top navbar on scroll
                   $(window).on("scroll", function () {
                       if ($(window).scrollTop() > 100) {
                           $(".tm-top-bar").addClass("active");
                       } else {
                           $(".tm-top-bar").removeClass("active");
                       }
                   });

                   // Smooth scroll to search form
                   $('.tm-down-arrow-link').on("click", function () {
                       $.scrollTo('#tm-section-search', 300, { easing: 'linear' });
                   });

                   // Date Picker in Search form
                   var pickerCheckIn = datepicker('#inputCheckIn');
                   var pickerCheckOut = datepicker('#inputCheckOut');

                   // Update nav links on scroll
                   $('#tm-top-bar').singlePageNav({
                       currentClass: 'active',
                       offset: 60
                   });

                   // Close navbar after clicked
                   $('.nav-link').on("click", function () {
                       $('#mainNav').removeClass('show');
                   });

                   // Slick Carousel
                   $('.tm-slideshow').slick({
                       infinite: true,
                       arrows: true,
                       slidesToShow: 1,
                       slidesToScroll: 1
                   });

                   loadGoogleMap();                                       // Google Map                
                   $('.tm-current-year').text(new Date().getFullYear());  // Update year in copyright           
               });

                </script>
            </footer>
        </div>
    </form>
</body>
</html>
