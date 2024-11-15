function fetchAIContent() {
    let interests_arr = []
    $.each($("input[name='interests[]']:checked"), function () {
        interests_arr.push($(this).val());
    });
    let cuisine_arr = []
    $.each($("input[name='cuisine-type[]']:checked"), function () {
        cuisine_arr.push($(this).val());
    });
    let user_input = {
        ctry_name: $("#country").val() == "" ? "Paris" : $("#country").val(),
        budget: $("#budget").val() == "" ? "500USD" : $("#budget").val(),
        days: $("#days").val() == "" ? "4" : $("#days").val(),
        interests: interests_arr.length == 0 ? ["History", "Food", "Art"] : interests_arr,
        travel_style: $("#travel-style").find(":selected").val() == "" ? "Leisure" : $("#travel-style").find(":selected").val(),
        accommodation: $("#accommodation").find(":selected").val() == "" ? "Hotel" : $("#accommodation").find(":selected").val(),
        transportation: $("#transportation").val() == "" ? "Public" : $("#transportation").val(),
        activity_arr: $("#activity-type").val().length == 0 ? ["Sightseeing", "Shopping"] : $("#activity-type").val(),
        cuisine_arr: cuisine_arr.length == 0 ? ["Indian", "Mexican", "Japanese", "Italian"] : cuisine_arr
    }

    console.log(user_input)

    let prompt = `Give this response in this json format {"dayn":{"morning":"insert value here", "afternoon":"insert value here", "evening":"insert value here"}}: Generate a personalized travel itinerary for a trip to ${user_input["ctry_name"]} with a budget of ${user_input["budget"]}. The traveler is interested in a ${user_input["travel_style"]} vacation and enjoys ${user_input["interests_arr"]}. They are looking for ${user_input["accommodation"]} accommodations with real accomodation places and prefer ${user_input["transportation"]} transportation. The itinerary should include ${user_input["activity_arr"]} activities and ${user_input["cuisine_arr"]} dining options. Please provide a detailed itinerary with daily recommendations for ${user_input["days"]} days, including suggested destinations, activities, and dining options.Also provide full information and explain in detail about all the days. The itinerary should be written in English and itenary should be detailed send the response in JSON format strictly with distinction of morning, afternoon, evening in string format with all the keys in lowercase and no space`


    prompt_json = { "prompt": prompt }


    // $.ajax({
    //     url: 'https://api.nova-oss.com/v1/chat/completions',
    //     type: 'POST',
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer nv2-3Zpvcula1hJIbbsvrSTC_NOVA_v2_rA6q0m33PJR24x7KnuZ7'
    //     },
    //     data: JSON.stringify({   
    //             model: "gpt-3.5-turbo-0613", 
    //             messages: [{"role": "user", "content": `Generate a personalized travel itinerary for a trip to ${user_input["ctry_name"]} with a budget of ${user_input["budget"]}. The traveler is interested in a ${user_input["travel_style"]} vacation and enjoys ${user_input["interests_arr"]}. They are looking for ${user_input["accommodation"]} accommodations and prefer ${user_input["transportation"]} transportation. The itinerary should include ${user_input["activity_arr"]} activities and ${user_input["cuisine_arr"]} dining options. Please provide a detailed itinerary with daily recommendations for ${user_input["days"]} days, including suggested destinations, activities, and dining options.Also provide full information and explain in detail about all the days. The itinerary should be written in English with all the links of hotel and attractions inside an html anchor tag without css, send the response in JSON format with distinction of morning, lunch, afternoon, dinner without newline`}]
    //     }),
    //     beforeSend: function(){
    //         $("#ai-response").html("")
    //         console.log("hoving")
    //         $('#spinner').show()
    //       },
    //       complete: function(){
    //         console.log("doning")
    //         $('#spinner').hide();
    //     },
    //     success: function(response) {
    //       text = response["choices"][0]["message"]["content"]
    //       console.log(response)
    //       $("#ai-response").html(text)

    //     },
    //     error: function(xhr, status, error) {
    //       // Handle any errors here
    //       console.log('Error:', error);
    //     }
    //   });

    $.ajax({
        url: 'http://127.0.0.1:5000/getplan',
        type: 'POST',
        contentType: "application/json; charset=UTF-8",
        dataType: 'json',
        data: JSON.stringify(prompt),
        success: function (response) {
            console.log(response)
            design_page(response[0]["response"])
        },
        beforeBegin: function () {
            $("#spinner").show()
        },
        complete: function () {
            $("#spinner").hide()
        }

    })
}

function design_page(response_json) {
    // console.log(response_json)
    response_json = JSON.parse(response_json)
    html_create = `<thead>
    <tr>
        <th class="border-4 border-gray-700">Day</th>
        <th class="border-4 border-gray-700">Morning</th>
        <th class="border-4 border-gray-700">Afternoon</th>
        <th class="border-4 border-gray-700">Evening</th>
    </tr>
  </thead>`
    keys = Object.keys(response_json)
    for (let day in response_json) {
        html_create += `<tbody><tr>
    <td class="border-4 border-gray-700 p-2">${day[0].toUpperCase() + day.slice(1).toLowerCase()}</td>
    <td class="border-4 border-gray-700 p-2">${response_json[day]["morning"]}</td>
    <td class="border-4 border-gray-700 p-2">${response_json[day]["afternoon"]}</td>
    <td class="border-4 border-gray-700 p-2">${response_json[day]["evening"]}</td>
  </tr>`
    };

    html_create += `</tbody>`


    $(".show-resp").html(html_create)
}
