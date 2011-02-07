var $j = jQuery.noConflict();				
	
			$j(document).ready(
		      
			  function(){
			  	generatePostTabs();
            
            $j('input#withcallback').geoLocationPicker({
              defaultAddressCallback: getAddress,
              left: "0px"
            });

			  	$j("#moje_ogloszenia").click(
				  function(){
				    if($j("#login_panel").css("display")=="none"){
					generateMessageBox($j(this), true);}
				  });
				$j("#close_button").click(
				  function(){	
					 hideMsg();
				  }
				);
				$j("#city_label").click(
					function(){
						$j(this).next().animate({height:'toggle'});	
			 	 });
				$j("#categories_label").click(
					function(){
						$j(this).next().animate({height:'toggle'});	
			 	 });
				$j("#categories_box img").click(
					function(){
						var div_up = $j(this).closest('div');
						div_up.next().animate({height:'toggle'});
					}
				);
				$j(".sliding_categories_div").each(function(){
					var div_up = $j(this).closest("div");
					if($j(this).css("display")=="none"){
						
						div_up.children().find("img").attr({src: 'images/minus_icon.jpg'});
					}
					else{
					     	div_up.children().find("img").attr({src: 'images/plus_icon.jpg'});
					}						
				});
			});
			function hideMsg(){
				$j("#login_panel").hide();
			}
			function showLoginDescription(){
				$j("#login_panel span").show("fast");
			}
			function split(string, zakres){
				var len = string.length;
				var tempString = "";
				for(var i = 0; i < len-zakres; i++){
					tempString += string[i];
				}
				if(tempString == "")
				  return false;
				return tempString;
			}
			function generateMessageBox(target, display ){
				if(display == true){
					var objOfTarget = target;//$j("#" + target);
					var posOfTarget = objOfTarget.position();
					
					var messageDiv = $j("#login_panel");
					var topPosition = parseInt(posOfTarget.top + parseInt(split(objOfTarget.css("height"), 2)) ) - 20;
					var leftPosition = parseInt(posOfTarget.left)-30;
					messageDiv.show("fast");
					$j("#login_panel span").css("display", "none");
					messageDiv.css({"top" : topPosition, "left" : leftPosition});
				}
				setTimeout("showLoginDescription()", 1);
				//setTimeout("hideMsg()", 5000);
			}
			function generatePostTabs() {
			  var tabContainers = $j('div.create_post > div');
			  tabContainers.hide().filter(':first').show();
			  $j('ul.create_post_navigation a').click(function () {
			    tabContainers.hide();
			    tabContainers.filter($j(this).attr("class")).show();
			    $j('div.create_post ul.create_post_navigation a').removeClass('selected');
		  	    $j(this).addClass('selected');
			    return false;
			    }).filter(':first').click();
			 }

//-------------------------------------Google maps------------------------------------------------

    function getAddress(){
              return $j('#address').val();
            }
			
