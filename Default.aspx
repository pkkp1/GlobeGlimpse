1<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>GlobeGlimpse</title>
    <link href="globe/style.css" rel="stylesheet" />
    <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/map.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
    <link rel="stylesheet" href="css/templatemo-style.css" />
    <style>
        #btnsubmit {
            background: #AB7836;
            border: none;
            color: white;
            border-radius: 0;
            outline: none;
        }

            #btnsubmit:hover {
                background-color: #323B60;
            }
    </style>
    <script src="//cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <script src="//cdn.amcharts.com/lib/5/themes/Micro.js"></script>
    <script src="//cdn.amcharts.com/lib/5/themes/Kelly.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#nl1").on("click", function () {
                $("#nl1").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#nl2").on("click", function () {
                $("#nl2").addClass("active");
                $("#nl1").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#nl3").on("click", function () {
                $("#nl3").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl1").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#blg").on("click", function () {
                window.location.assign(window.location.origin + "/ourblogs.aspx");
            });
            $("#ai").on("click", function () {
                window.location.assign(window.location.origin + "/aipage.html");
            });
            $("#chat").on("click", function () {
                window.location.assign(window.location.origin + "/Chat.aspx?Room=26t58Za50K");
            });
            $("#nl5").on("click", function () {
                $("#nl5").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl1").removeClass("active");
            });
            $("#btnsubmit").on("click", function () {
                let uname = $("#contact_name").val();
                let mail = $("#contact_email").val();
                let num = $("#contact_number").val();
                let msg = $("#contact_message").val();
                if ((!isNaN(num) && num.length >= 10)) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/SendInfo",
                        data: "{'uName':'" + uname + "','mail':'" + mail + "','num':'" + num + "','msg':'" + msg + "'}",
                        dataType: "json",
                        success: function () {
                            alert("Your Response has been sent ;)");
                        },
                        error: function (request, err) {
                            alert("There was an error sending your response :(");
                        }
                    });
                    $("#u_name").val("");
                    $("#u_mail").val("");
                    $("#u_num").val("");
                    $("#u_msg").val("");
                }
                else {
                    alert("Value of Number should be Numeric");
                    $("#u_num").val("");
                    $("#u_num").focus();
                }
            });
        });
    </script>
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
                                            <a id="ai" class="nav-link">AI</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="blg" class="nav-link">Blog</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="chat" class="nav-link">Chat</a>
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

                <div class="tm-page-wrap mx-auto" style="max-width: 1400px!important;">
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
                        <!-- row -->
                        <div class="tm-banner-overlay" style="min-height: 842px!important; z-index: 3!important;"></div>
                    </section>
                </div>
                <!-- .container -->
            </div>
            <!-- .tm-container-outer -->

            <div class="tm-page-wrap" style="z-index: 4!important; position: sticky!important;">
                <section class="p-5 tm-container-outer">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
                                <h2 class="text-uppercase mb-4">Your <strong>Journey</strong> is our priority</h2>
                                <p class="mb-4">Providing you with best possible trips and joyful experiences under a reasonable price is our main priority. We look forward to provide you with new ways to look at the world and assist you finding the true vacation you and your loved ones deserve.</p>
                                <a href="#tm-section-3" class="text-uppercase btn-primary tm-btn">Explore Further</a>
                            </div>
                        </div>
                    </div>
                </section>

                <div class="tm-container-outer" id="tm-section-2">
                    <section class="tm-slideshow-section">
                        <div class="tm-slideshow">
                            <img src="img/tajmahel.jpg" alt="Image" />
                            <img src="img/varanasi.jpg" alt="Image" />
                            <img src="img/sou.jpeg" alt="Image" />
                        </div>
                        <div class="tm-slideshow-description tm-bg-primary">
                            <h2 class="">Majestic India</h2>
                            <p>One of the oldest civilisations in the world, India is a mosaic of multicultural experiences. With a rich heritage and myriad attractions, the country is among the most popular tourist destinations in the world. It covers an area of 32, 87,263 sq. km, extending from the snow-covered Himalayan heights to the tropical rain forests of the south.</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-primary">Explore Further</a>
                        </div>
                    </section>
                    <section class="clearfix tm-slideshow-section tm-slideshow-section-reverse">

                        <div class="tm-right tm-slideshow tm-slideshow-highlight">
                            <img src="img/swiss1.jpg" alt="Image" />
                            <img src="img/swiss2.jpg" alt="Image" />
                            <img src="img/swiss3.png" alt="Image" />
                        </div>

                        <div class="tm-slideshow-description tm-slideshow-description-left tm-bg-highlight">
                            <h2 class="">Stunning Switzerland</h2>
                            <p>Embark on a Swiss adventure with us! We're dedicated to curating unforgettable experiences at unbeatable prices. Discover new perspectives in the heart of Switzerland. Let us help you find the perfect vacation you and your loved ones deserve. Your journey to picturesque landscapes and cultural richness begins here!</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-highlight">Explore Further</a>
                        </div>

                    </section>
                    <section class="tm-slideshow-section">
                        <div class="tm-slideshow">
                            <img src="img/egy1.jpeg" alt="Image">
                            <img src="img/egy2.jpg" alt="Image">
                            <img src="img/egy3.jpg" alt="Image">
                        </div>
                        <div class="tm-slideshow-description tm-bg-primary">
                            <h2 class="">Mystical Egypt</h2>
                            <p>Experience the magic of Egypt with our carefully curated tours. Immerse yourself in ancient history, explore awe-inspiring pyramids, and cruise along the Nile River. We prioritize delivering exceptional trips and unforgettable moments, all within your budget. Discover a new perspective on Egypt, tailored for you and your loved ones.</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-primary">Explore Further</a>
                        </div>
                    </section>
                </div>
                <div class="tm-container-outer" id="tm-section-3">
                    <ul class="nav nav-pills tm-tabs-links">
                        <li class="tm-tab-link-li">
                            <a href="#1a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/north-america.png" alt="Image" class="img-fluid">
                                North America
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#2a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/south-america.png" alt="Image" class="img-fluid">
                                South America
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#3a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/europe.png" alt="Image" class="img-fluid">
                                Europe
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#4a" data-toggle="tab" class="tm-tab-link active">
                                <!-- Current Active Tab -->
                                <img src="img/asia.png" alt="Image" class="img-fluid">
                                Asia
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#5a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/africa.png" alt="Image" class="img-fluid">
                                Africa
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#6a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/australia.png" alt="Image" class="img-fluid">
                                Australia
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content clearfix">

                        <!-- Tab 1 -->
                        <div class="tab-pane fade" id="1a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/nyc.png" alt="Imagetm-page-wrap" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">NYC, New York</h3>
                                        <p class="tm-text-highlight">United States</p>
                                        <p class="tm-text-gray">Known as "The Big Apple," it's a global hub for culture, fashion, art, and finance. Don't miss the Statue of Liberty, Times Square, Central Park, and Broadway.Nestled in the heart of the United States, New York City is a vibrant metropolis celebrated for its iconic skyline, world-class museums, and diverse neighborhoods. Visitors can explore renowned landmarks such as the Statue of Liberty, Central Park, and Times Square. With its bustling streets and rich cultural tapestry, NYC offers an unmatched urban experience for travelers and locals alike.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/benff.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Benff National Park, Alberta</h3>
                                        <p class="tm-text-highlight">Canada</p>
                                        <p class="tm-text-gray">Nestled in the Canadian Rockies, Banff National Park boasts unparalleled alpine grandeur. Majestic peaks guard emerald lakes, while pristine forests teem with wildlife. Hiking trails wind through this wilderness, unveiling hidden wonders. Surreal glaciers glisten, sculpting the landscape. Charming Banff town invites with its alpine allure. This sanctuary harmonizes rugged beauty and serene tranquility, enchanting all who venture here.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/cancun.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Cancún, Quintana Roo</h3>
                                        <p class="tm-text-highlight">Mexico</p>
                                        <p class="tm-text-gray">Cancún, nestled on Mexico's Caribbean coast, is a tropical paradise renowned for its pristine beaches, azure waters, and vibrant nightlife. This idyllic destination invites travelers to explore ancient Mayan ruins at Tulum, revel in aquatic adventures like snorkeling in the Great Mesoamerican Reef, and savor delectable Mexican cuisine. With luxurious resorts and a lively atmosphere, Cancún promises an unforgettable escape.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/manuel.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Manuel Antonio National Park</h3>
                                        <p class="tm-text-highlight">Costa Rica</p>
                                        <p class="tm-text-gray">Located on the Pacific coast, Nestled along Costa Rica's Pacific coastline, Manuel Antonio National Park is a verdant sanctuary teeming with biodiversity. Lush rainforests cascade towards pristine shores, where turquoise waves gently caress golden sands. This ecological jewel harbors capuchin monkeys, iridescent butterflies, and elusive three-toed sloths. Serpentine trails unveil hidden waterfalls and panoramic vistas, inviting intrepid explorers to embrace nature's symphony.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 2 -->
                        <div class="tab-pane fade" id="2a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/rdj.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Rio de Janeiro</h3>
                                        <p class="tm-text-highlight">Brazil</p>
                                        <p class="tm-text-gray">Known for its breathtaking natural beauty, Rio de Janeiro is famous for its iconic landmarks like the Christ the Redeemer statue and Sugarloaf Mountain. The city's vibrant culture, stunning beaches (such as Copacabana and Ipanema), and lively neighborhoods like Lapa and Santa Teresa make it a must-visit destination. Additionally, the Tijuca National Park offers lush rainforest and hiking opportunities right within the city. The annual Carnival celebration is a world-famous event that draws visitors from around the globe.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/iguazu.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Iguazu Falls</h3>
                                        <p class="tm-text-highlight">Argentina</p>
                                        <p class="tm-text-gray">Located in the northeastern part of the country on the border with Brazil, Iguazu Falls is one of the most spectacular natural wonders in the world. It's a collection of over 270 individual waterfalls that span nearly two miles, surrounded by lush rainforest. Visitors can explore various trails and platforms to view the falls from different angles, take boat tours to get up close, and even go on a thrilling jungle safari. The sheer size and power of Iguazu Falls make it a must-see destination for any traveler in Argentina.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/machu.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Machu Picchu</h3>
                                        <p class="tm-text-highlight">Peru</p>
                                        <p class="tm-text-gray">This ancient Incan city is nestled high in the Andes Mountains and is renowned for its breathtaking scenery and archaeological significance. It's considered one of the most iconic and well-preserved archaeological sites in the world. Visitors can explore the impressive stone structures, terraces, and soak in the awe-inspiring views of the surrounding mountains. The Inca Trail leading to Machu Picchu is also a popular trekking route for adventure seekers.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/torres.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Torres del Paine National Park</h3>
                                        <p class="tm-text-highlight">Chile</p>
                                        <p class="tm-text-gray">Located in the Patagonian region of southern Chile, Torres del Paine is renowned for its breathtaking landscapes featuring rugged mountains, glaciers, emerald lakes, and diverse wildlife. Visitors can embark on epic hikes, including the famous "W" and "O" circuits, offering unparalleled views of the park's iconic granite peaks, known as the "Towers." This park is a haven for outdoor enthusiasts and nature lovers alike.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 3 -->
                        <div class="tab-pane fade" id="3a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/rome.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Rome</h3>
                                        <p class="tm-text-highlight">Italy</p>
                                        <p class="tm-text-gray">Known as the "Eternal City," Rome is a living museum of history, with ancient ruins like the Colosseum, the Roman Forum, and the Pantheon. It's also home to iconic landmarks such as St. Peter's Basilica, the Vatican Museums, and the Trevi Fountain. Visitors can soak in the rich culture, indulge in delicious Italian cuisine, and explore the vibrant neighborhoods of this enchanting city.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/paris.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Paris</h3>
                                        <p class="tm-text-highlight">France</p>
                                        <p class="tm-text-gray">Known as the "City of Lights," Paris is celebrated for its iconic landmarks such as the Eiffel Tower, Louvre Museum, and Notre-Dame Cathedral. It exudes romance, with charming streets, world-class cuisine, and the Seine River flowing through its heart. The city's rich history and cultural treasures make it a top destination for travelers from around the world.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/barcelona.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Barcelona</h3>
                                        <p class="tm-text-highlight">Spain</p>
                                        <p class="tm-text-gray">This vibrant city on the northeastern coast of Spain is renowned for its unique architecture, including the iconic works of Antoni Gaudí such as the Sagrada Família and Park Güell. Barcelona also offers beautiful beaches, a rich cultural scene, and a lively atmosphere with bustling markets, tapas bars, and a dynamic arts and music scene.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/cappadocia.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Cappadocia</h3>
                                        <p class="tm-text-highlight">Turkey</p>
                                        <p class="tm-text-gray">This enchanting region in central Turkey is famous for its surreal landscapes of cone-shaped rock formations, ancient cave dwellings, and fairy chimneys. Visitors can take hot air balloon rides for a breathtaking aerial view, explore underground cities, and hike through unique terrain. Cappadocia's rich history and otherworldly scenery make it a truly exceptional destination.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 4 -->
                        <div class="tab-pane fade show active" id="4a">
                            <!-- Current Active Tab WITH "show active" classes in DIV tag -->
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/mbs.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Marina Bay Sands</h3>
                                        <p class="tm-text-highlight">Singapore</p>
                                        <p class="tm-text-gray">This iconic integrated resort is a symbol of modern Singapore. It features a stunning rooftop pool with panoramic city views, a world-class casino, luxury shopping, and a range of dining options. The SkyPark, perched 200 meters above ground, offers breathtaking vistas of the city skyline. It's a must-visit for travelers seeking a blend of luxury, entertainment, and architectural marvels.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/bagan.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Bagan</h3>
                                        <p class="tm-text-highlight">Myanmar</p>
                                        <p class="tm-text-gray">nown as the "Land of a Thousand Pagodas," Bagan is an ancient city in Myanmar that boasts over 2,000 well-preserved temples and pagodas. Visitors can explore this archaeological wonder by cycling or hot air ballooning over the plains, taking in breathtaking views of the historic skyline. The rich cultural heritage and stunning sunsets make Bagan a truly enchanting destination.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/bangkok.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Bangkok</h3>
                                        <p class="tm-text-highlight">Thailand</p>
                                        <p class="tm-text-gray">Thailand's bustling capital city, Bangkok, is a vibrant metropolis known for its ornate temples, bustling markets, and vibrant street life. Visitors can explore the grandeur of the Grand Palace, experience the spiritual aura of Wat Pho, and cruise along the Chao Phraya River. The city also offers a diverse culinary scene, bustling nightlife, and a mix of modern and traditional culture.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/jaipur.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Jaipur</h3>
                                        <p class="tm-text-highlight">India</p>
                                        <p class="tm-text-gray">Known as the "Pink City," Jaipur is a vibrant blend of history, culture, and architectural marvels. The city boasts stunning palaces like the Hawa Mahal, majestic forts like the Amer Fort, and the opulent City Palace. Visitors can also explore bustling markets, savor delectable Rajasthani cuisine, and experience the rich heritage of this royal city.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 5 -->
                        <div class="tab-pane fade" id="5a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/cape.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Cape Town, Western Cape</h3>
                                        <p class="tm-text-highlight">South Africa</p>
                                        <p class="tm-text-gray">Nestled beneath the iconic Table Mountain, Cape Town is a captivating blend of natural beauty, rich history, and vibrant culture. Visitors can explore the Cape of Good Hope, stroll along the Victoria & Alfred Waterfront, and sample world-class wines in nearby vineyards. With its stunning beaches, diverse cuisine, and a host of activities, Cape Town offers an unforgettable travel experience.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/masai.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Maasai Mara National Reserve</h3>
                                        <p class="tm-text-highlight">Kenya</p>
                                        <p class="tm-text-gray">Located in southwestern Kenya, the Maasai Mara is renowned for its incredible biodiversity and the annual Great Migration of wildebeest and zebra. Visitors can witness this natural spectacle, as well as explore the savannahs teeming with wildlife like lions, elephants, and giraffes. The reserve offers unforgettable safari experiences amidst stunning African landscapes.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/marra.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Marrakech</h3>
                                        <p class="tm-text-highlight">Morocco</p>
                                        <p class="tm-text-gray">Known as the "Red City," Marrakech is a captivating blend of ancient traditions and modern influences. The bustling medina is a UNESCO World Heritage site, offering vibrant markets, stunning palaces like the Bahia Palace, and the iconic Koutoubia Mosque. Visitors can also explore the serene Majorelle Garden and experience the lively atmosphere of the Jemaa el-Fnaa square, where musicians, storytellers, and artisans gather.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/giza.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Giza Necropolis</h3>
                                        <p class="tm-text-highlight">Egypt</p>
                                        <p class="tm-text-gray">This ancient wonder is home to the iconic Pyramids of Giza, including the Great Pyramid of Khufu, one of the Seven Wonders of the Ancient World. Adjacent is the enigmatic Sphinx. These monumental structures stand as testaments to the engineering prowess of ancient Egypt and are steeped in history and mystery.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 6 -->
                        <div class="tab-pane fade" id="6a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/sydney.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Sydney</h3>
                                        <p class="tm-text-highlight">New South Wales</p>
                                        <p class="tm-text-gray">Sydney, the capital of New South Wales, is Australia's largest and most iconic city. Situated on the stunning shores of Sydney Harbour, it's celebrated for its world-renowned landmarks, including the Sydney Opera House and the Sydney Harbour Bridge. The city offers a rich blend of cultural diversity, with vibrant neighborhoods, exquisite dining, and a thriving arts scene. Surrounded by beautiful beaches and national parks, Sydney seamlessly combines urban sophistication with natural beauty.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/gbr.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Great Barrier Reef</h3>
                                        <p class="tm-text-highlight">Queensland</p>
                                        <p class="tm-text-gray">The Great Barrier Reef, located off the coast of Queensland, Australia, is the world's largest coral reef system. It spans over 2,300 kilometers and is a UNESCO World Heritage site. This natural wonder is home to an astounding array of marine life, including colorful corals, diverse fish species, sharks, turtles, and rays. It offers unparalleled snorkeling and diving experiences, allowing visitors to witness the incredible biodiversity of the underwater world. The reef is a globally significant ecosystem and a must-see destination for nature enthusiasts and adventure seekers alike.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/uluru.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Uluru-Kata Tjuta National Park</h3>
                                        <p class="tm-text-highlight">Northern Territory</p>
                                        <p class="tm-text-gray">Uluru-Kata Tjuta National Park, situated in the Northern Territory of Australia, is a sacred Aboriginal site of profound cultural and natural significance. At its heart stands Uluru, an immense sandstone monolith known for its mesmerizing color changes at sunrise and sunset. Nearby, Kata Tjuta, or "The Olgas," forms a dramatic cluster of ancient rock formations. The park is rich in Aboriginal history and offers visitors a chance to learn about the cultural and spiritual heritage of the Anangu people. It's a place of deep reverence and natural splendor.</p>
                                    </div>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/mel.png" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Melbourne</h3>
                                        <p class="tm-text-highlight">Victoria</p>
                                        <p class="tm-text-gray">Melbourne, the capital of Victoria, is Australia's cultural hub, renowned for its creativity, diversity, and dynamic atmosphere. The city boasts a thriving arts scene, with numerous galleries, theaters, and street art. Its laneways are lined with eclectic boutiques and cafés, showcasing Melbourne's unique sense of style. The culinary landscape is exceptional, offering a diverse range of global cuisines. Melbourne is also known for its lively events, including the Australian Open tennis tournament and the Melbourne Cup horse race. With its blend of culture, fashion, and gastronomy, Melbourne is a city of constant discovery and inspiration.</p>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="text-uppercase btn-primary tm-btn mx-auto tm-d-table">Show More Places</a>
                        </div>
                    </div>
                </div>

                <div class="tm-container-outer tm-position-relative" id="tm-section-4">
                    <div id="google-map" style="z-index: 1; background-image: url(../img/logo/bgcontact.png); background-repeat: no-repeat; background-size: cover;"></div>
                    <div class="tm-banner-overlay1" style="z-index: 2; min-height: auto!important;"></div>
                    <div class="tm-contact-form" style="z-index: 3;">
                        <div class="form-group tm-name-container">
                            <input type="text" id="contact_name" name="contact_name" class="form-control" placeholder="Name" required="required" />
                        </div>
                        <div class="form-group tm-email-container">
                            <input type="email" id="contact_email" name="contact_email" class="form-control" placeholder="Email" required="required" />
                        </div>
                        <div class="form-group">
                            <input type="text" id="contact_number" name="contact_number" class="form-control" placeholder="Contact Number" required="required" />
                        </div>
                        <div class="form-group">
                            <textarea id="contact_message" name="contact_message" class="form-control" rows="9" placeholder="Message" required="required"></textarea>
                        </div>
                        <button id="btnsubmit" type="button" class="btn tm-btn-primary tm-btn-send text-uppercase">Send Message Now</button>
                    </div>
                </div>
            </div>
            <!-- .tm-container-outer -->

            <footer class="tm-container-outer" style="background-color: #AB7836;">
                <p class="mb-0">
                    Copyright © <span class="tm-current-year">2018</span> GlobeGlimpse
                        
                    . Designed by <a rel="nofollow" href="http://www.google.com/+templatemo" target="_parent">PSK</a>
                </p>
            </footer>
        </div>
    </form>
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
</body>
</html>
