var $j = jQuery.noConflict();				
	
			$j(document).ready(      
			  function(){
			  	generatePostTabs();
                addCityAutocomplete();   
                Event.observe(window, "load", function() {
		        TextileEditor.initialize("content_text_area", "extended");

//---------------------------------upload----------------------------------
    $j('.photo_lightbox').lightBox({fixedNavigation:true});
 
  $j('.upload').fileUploadUI({
    uploadTable: $j('#upload_files'),
    downloadTable: $j('#download_files'),
    buildUploadRow: function(files, index){
      var file=files[index];
       
      return $j('<tr><td>' + file.name + '<\/td>' +
	                    '<td class="file_upload_progress"><div><\/div><\/td>' +
	                    '<td class="file_upload_cancel">' +
	                    '<div class="ui-state-default ui-corner-all ui-state-hover" title="Cancel">' +
	                    '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
	                    '<\/div><\/td><\/tr>');
    },
buildDownloadRow: function(file){
if(file.result !='error'){
   return $j('<tr alt="'+file.id+'"><td ><a class="photo_lightbox"><img  alt="picture" width="100" src="' + file.img_path + '"><\/a>' + file.name + '<\/td><td><script>'+
                 ' $j(".delete_photo_link").click(function(){'+
                   ' var id = $j(this).attr("id");'+
                   ' $j.ajax({'+
                     'type: "GET",'+
                     'url: "upload_previews\/"+id+"\/destroy",'+
                     'success: function(){$j("tr[alt='+file.id+']").hide();}'+
                    '});});'

+'<\/script><label style="background-color:red;" class="delete_photo_link" id="'+file.id+'">usun<\/label><\/td><\/tr>');
} else{
  return $j('<script>alert("za duza ilosc zalaczników");<\/script>');}
  }
    });
//----------------------------------upload----------------------------------------
                $j('#click').click(function(){
                  $j('#upload_preview_img').click();

                   });
//----------------------------------scroll up-------------------------------------
              
//--------------------------------------------------------------------------------
                $j('#disable_formatting').click(function(){
                  $j(this).css("display","none");
                  $j('#enable_formatting').css("display", "block");
                  disableFormatting();
                  //hideSettingsMsg();
                    });
                $j('#enable_formatting').click(function(){
                  $j(this).css("display","none");
                  $j('#disable_formatting').css("display","block");
                  enableFormatting();
                  //hideSettingsMsg();
                    });
		         });
               $j('#clear_form').click(function(){
                 $j('#first_post_tab input').each(function(){
                   $j(this).val('');
              });

                $j('#first_post_tab textarea').each(function(){
                   $j(this).val('');
                  });
                });
               $j('#content_settings').click(function(){
                    addSettingsPosition();
                 $j('#content_settings_list').animate({height:'toggle'});
                 setTimeout("hideSettingsMsg()", 2000);
               });
               
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
					 hideLoginMsg();
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
				$j("sliding_categories_div").each(function(){
                    //var button_id=$j(this).attr('id');
					//var img_up = $j('img.'+button_id);
      
				 
				});
			});
			function hideLoginMsg(){
				$j("#login_panel").hide();
			}
            function hideSettingsMsg(){
                $j('#content_settings_list').hide('slow');
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
            function addSettingsPosition(){
              var obj = $j('#content_settings>a');
              var posOfTarget = obj.position();
              var message_ = $j('#content_settings_list');
			  var topPosition = parseInt(posOfTarget.top + parseInt(split(obj.css("height"), 2)) );
		      var leftPosition = parseInt(posOfTarget.left)-30;
			  message_.css({"top" : topPosition, "left" : leftPosition});
             }
//-------------------------------------Google maps------------------------------------------------

    function getAddress(){
              return $j('.city').val()+', '+$j('.street').val() +' '+$j('.house_number').val() + ' ' +  $j('.state').val();
            }
//------------------------------------Autocomplete-----------------------------------------------
// dodac ajax
	function addCityAutocomplete() {
		var cities = [
		"Wałbrzych","Wrocław","Bydgoszcz","Toruń","Lublin","Chełm","Zielona Góra","Zamość","Bełchatów","Łódź","Kraków","Tarnów","Warszawa","Płock","Legionowo"
		];
		$j( ".city" ).autocomplete({
			source: cities
		});
	}
//-----------------------------------Textile-----------------------------------------------------
function disableFormatting(){
     $j('.textile-toolbar>button').each(function(index){
        $j(this).attr("disabled", "true");
        });
}
function enableFormatting(){
    $j('.textile-toolbar>button').each(function(index){
        $j(this).attr("disabled", "");
});
}

			
